import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart' as models;
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/interceptor/auth_interceptor.dart';
import 'package:myecl/tools/repository/constants.dart';
import 'package:universal_html/html.dart' as html;

class AuthRepository {
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final CacheManager cacheManager = CacheManager();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Base64Codec base64 = const Base64Codec.urlSafe();
  final Openapi openIdRepository =
      Openapi.create(baseUrl: Uri.parse(BASE_URL), interceptors: [
    HeadersInterceptor({
      "Test": "ok",
    }),
    AuthInterceptor(),
  ]);
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String redirectUrl = "fr.myecl.titan://authorized";
  final String redirectUrlHost = "myecl.fr";
  final String discoveryUrl = "$BASE_URL.well-known/openid-configuration";
  final List<String> scopes = ["API"];
  models.TokenResponse tokenResponse = models.TokenResponse.fromJson({});

  AuthRepository();

  String generateRandomString(int len) {
    var r = Random.secure();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  String hash(String data) {
    return base64.encode(sha256.convert(utf8.encode(data)).bytes);
  }

  Future getTokenFromRequest() async {
    html.WindowBase? popupWin;

    final redirectUri = Uri(
      host: redirectUrlHost,
      scheme: "https",
      path: '/static.html',
    );
    final codeVerifier = generateRandomString(128);

    final authUrl =
        "${BASE_URL}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectUri&code_challenge=${hash(codeVerifier)}&code_challenge_method=S256";

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
      completer.future.then((_) {
        tokenResponse =
            const models.TokenResponse(accessToken: "", refreshToken: "");
      });

      void login(String data) async {
        final receivedUri = Uri.parse(data);
        final token = receivedUri.queryParameters["code"];
        if (popupWin != null) {
          popupWin!.close();
          popupWin = null;
        }
        try {
          if (token != null && token.isNotEmpty) {
            final resp = await openIdRepository.authTokenPost(
                body: models.BodyTokenAuthTokenPost(
              grantType: "authorization_code",
              code: token,
              redirectUri: redirectUri.toString(),
              codeVerifier: codeVerifier,
              clientId: clientId,
            ));
            if (resp.isSuccessful) {
              final refreshToken = resp.body!.refreshToken;
              await _secureStorage.write(key: tokenName, value: refreshToken);
              tokenResponse = resp.body!;
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

      html.window.onMessage.listen((event) {
        if (event.data.toString().contains('code=')) {
          login(event.data);
        }
      });
    } else {
      AuthorizationTokenResponse? resp = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          scopes: scopes,
        ),
      );
      if (resp != null) {
        await _secureStorage.write(key: tokenName, value: resp.refreshToken);
        tokenResponse = models.TokenResponse(
          accessToken: resp.accessToken!,
          refreshToken: resp.refreshToken!,
        );
      } else {
        throw Exception('Wrong credentials');
      }
    }
  }

  Future getTokenFromStorage() async {
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        if (kIsWeb) {
          final resp = await openIdRepository.authTokenPost(
              body: models.BodyTokenAuthTokenPost(
            grantType: "refresh_token",
            refreshToken: token,
            clientId: clientId,
          ));
          if (resp.isSuccessful) {
            final refreshToken = resp.body!.refreshToken;
            await _secureStorage.write(key: tokenName, value: refreshToken);
            tokenResponse = resp.body!;
          } else {
            throw Exception('Wrong credentials');
          }
        } else {
          final resp = await appAuth.token(TokenRequest(
            clientId,
            redirectUrl,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
            refreshToken: token,
          ));
          if (resp != null) {
            tokenResponse = models.TokenResponse(
              accessToken: resp.accessToken!,
              refreshToken: resp.refreshToken!,
            );
            storeToken();
          } else {
            throw Exception('Wrong credentials');
          }
        }
      } else {
        throw Exception('Wrong credentials');
      }
    });
  }

  Future<void> getAuthToken(String authorizationToken) async {
    appAuth
        .token(TokenRequest(
      clientId,
      redirectUrl,
      discoveryUrl: discoveryUrl,
      scopes: scopes,
      authorizationCode: authorizationToken,
    ))
        .then((resp) {
      if (resp != null) {
        tokenResponse = models.TokenResponse(
          accessToken: resp.accessToken!,
          refreshToken: resp.refreshToken!,
        );
      } else {
        throw Exception('Wrong credentials');
      }
    });
  }

  Future<bool> refreshToken() async {
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
      if (resp == null) {
        tokenResponse = const models.TokenResponse(
          accessToken: "",
          refreshToken: "",
        );
        return false;
      }
      tokenResponse = models.TokenResponse(
        accessToken: resp.accessToken!,
        refreshToken: resp.refreshToken!,
      );
      storeToken();
      return true;
    }
    tokenResponse = const models.TokenResponse(
      accessToken: "",
      refreshToken: "",
    );
    return false;
  }

  void storeToken() {
    if (tokenResponse.accessToken != "" && tokenResponse.refreshToken != "") {
      _secureStorage.write(key: tokenName, value: tokenResponse.refreshToken);
    }
  }

  void deleteToken() {
    _secureStorage.delete(key: tokenName);
    cacheManager.deleteCache(tokenName);
    cacheManager.deleteCache("id");
    tokenResponse = const models.TokenResponse(
      accessToken: "",
      refreshToken: "",
    );
  }
}

final authRepositoryProvider = Provider((ref) => AuthRepository());
