import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart' as models;
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/functions.dart';
import 'package:universal_html/html.dart' as html;

class AuthRepository {
  final Openapi openIdRepository;
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final CacheManager cacheManager = CacheManager();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Base64Codec base64 = const Base64Codec.urlSafe();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String redirectUrl = "fr.myecl.titan://authorized";
  final String redirectUrlHost = "myecl.fr";
  final String discoveryUrl =
      "${getTitanHost()}.well-known/openid-configuration";
  final List<String> scopes = ["API"];

  AuthRepository({required this.openIdRepository});

  String generateRandomString(int len) {
    var r = Random.secure();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  String hash(String data) {
    return base64.encode(sha256.convert(utf8.encode(data)).bytes);
  }

  Future<models.TokenResponse> getTokenFromRequest() async {
    html.WindowBase? popupWin;

    final redirectUri = Uri(
      host: redirectUrlHost,
      scheme: "https",
      path: '/static.html',
    );
    final codeVerifier = generateRandomString(128);
    models.TokenResponse tokenResponse =
        EmptyModels.empty<models.TokenResponse>();

    final authUrl =
        "${getTitanHost()}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectUri&code_challenge=${hash(codeVerifier)}&code_challenge_method=S256";

    if (kIsWeb) {
      popupWin = html.window
          .open(authUrl, "Hyperion", "width=800, height=900, scrollbars=yes");

      final completer = Completer();
      void checkWindowClosed() {
        if (popupWin != null && popupWin!.closed == true) {
          completer.complete();
        } else {
          Future.delayed(const Duration(milliseconds: 100), checkWindowClosed);
        }
      }

      checkWindowClosed();
      completer.future.then((_) {});

      Future<models.TokenResponse> login(String data) async {
        final receivedUri = Uri.parse(data);
        final token = receivedUri.queryParameters["code"];
        if (popupWin != null) {
          popupWin!.close();
          popupWin = null;
        }
        try {
          if (token != null && token.isNotEmpty) {
            final response = await openIdRepository.authTokenPost(
              body: {
                "client_id": clientId,
                "code": token,
                "redirect_uri": redirectUri.toString(),
                "code_verifier": codeVerifier,
                "grant_type": "authorization_code",
                "refresh_token": token,
              },
            );
            if (response.isSuccessful && response.body != null) {
              storeToken(response.body!);
              return response.body!;
            } else {
              throw Exception('Wrong credentials');
            }
          } else {
            throw Exception('Wrong credentials');
          }
        } on TimeoutException catch (_) {
          throw Exception('No response from server');
        } catch (e) {
          rethrow;
        }
      }

      final event = await html.window.onMessage.first;
      if (event.data.toString().contains('code=')) {
        tokenResponse = await login(event.data);
      }
      return tokenResponse;
    } else {
      AuthorizationTokenResponse resp = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          scopes: scopes,
        ),
      );
      if (resp.accessToken != null && resp.refreshToken != null) {
        await _secureStorage.write(key: tokenName, value: resp.refreshToken);
        tokenResponse = models.TokenResponse(
          accessToken: resp.accessToken!,
          refreshToken: resp.refreshToken!,
        );
        storeToken(tokenResponse);
        return tokenResponse;
      } else {
        throw Exception('Wrong credentials');
      }
    }
  }

  Future<models.TokenResponse> getTokenFromStorage() async {
    models.TokenResponse tokenResponse =
        EmptyModels.empty<models.TokenResponse>();
    return _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          if (kIsWeb) {
            final response = await openIdRepository.authTokenPost(
              body: {
                "client_id": clientId,
                "code": token,
                "redirect_uri": "",
                "code_verifier": "",
                "grant_type": "refresh_token",
                "refresh_token": token,
              },
            );
            if (response.isSuccessful && response.body != null) {
              tokenResponse = response.body!;
              storeToken(tokenResponse);
            }
          } else {
            final resp = await appAuth.token(
              TokenRequest(
                clientId,
                redirectUrl,
                discoveryUrl: discoveryUrl,
                scopes: scopes,
                refreshToken: token,
              ),
            );
            if (resp.accessToken != null && resp.refreshToken != null) {
              tokenResponse = models.TokenResponse(
                accessToken: resp.accessToken!,
                refreshToken: resp.refreshToken!,
              );
              storeToken(tokenResponse);
            } else {
              throw Exception('Wrong credentials');
            }
          }
        } on TimeoutException catch (_) {
          throw Exception('No response from server');
        } catch (e) {
          rethrow;
        }
      } else {
        throw Exception('Wrong credentials');
      }
      return tokenResponse;
    });
  }

  Future<models.TokenResponse> getAuthToken(String authorizationToken) async {
    models.TokenResponse tokenResponse =
        EmptyModels.empty<models.TokenResponse>();
    appAuth
        .token(
      TokenRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        scopes: scopes,
        authorizationCode: authorizationToken,
      ),
    )
        .then((resp) {
      if (resp.accessToken != null && resp.refreshToken != null) {
        tokenResponse = models.TokenResponse(
          accessToken: resp.accessToken!,
          refreshToken: resp.refreshToken!,
        );
        storeToken(tokenResponse);
      } else {
        throw Exception('Wrong credentials');
      }
    });
    return tokenResponse;
  }

  Future<models.TokenResponse> refreshToken() async {
    models.TokenResponse tokenResponse =
        EmptyModels.empty<models.TokenResponse>();
    if (tokenResponse.refreshToken != "") {
      final resp = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          scopes: scopes,
          refreshToken: tokenResponse.refreshToken,
        ),
      );
      if (resp.accessToken == null || resp.refreshToken == null) {
        return tokenResponse;
      }
      tokenResponse = models.TokenResponse(
        accessToken: resp.accessToken!,
        refreshToken: resp.refreshToken!,
      );
      storeToken(tokenResponse);
      return tokenResponse;
    }
    return tokenResponse;
  }

  void storeToken(models.TokenResponse tokenResponse) {
    if (tokenResponse.accessToken != "" && tokenResponse.refreshToken != "") {
      _secureStorage.write(key: tokenName, value: tokenResponse.refreshToken);
    }
  }

  void deleteToken() {
    _secureStorage.delete(key: tokenName);
    cacheManager.deleteCache(tokenName);
    cacheManager.deleteCache("id");
  }
}

final authRepositoryProvider = Provider((ref) {
  final openIdRepository = Openapi.create(baseUrl: Uri.parse(getTitanHost()));
  return AuthRepository(openIdRepository: openIdRepository);
});
