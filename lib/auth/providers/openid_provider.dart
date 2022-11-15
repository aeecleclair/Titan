import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myecl/tools/repository/repository.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:http/http.dart' as http;

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<Map<String, String>>>(
        (ref) {
  OpenIdTokenProvider oauth2TokenRepository = OpenIdTokenProvider();
  oauth2TokenRepository.getTokenFromStorage();
  return oauth2TokenRepository;
});

final isLoggedInProvider = Provider((ref) {
  // return true;
  return ref.watch(authTokenProvider).when(
    data: (tokens) {
      return tokens["token"] == ""
          ? false
          : !JwtDecoder.isExpired(tokens["token"] as String);
    },
    error: (e, s) {
      return false;
    },
    loading: () {
      return false;
    },
  );
});

final loadingrovider = Provider((ref) {
  // return false;
  return ref.watch(authTokenProvider).when(
    data: (tokens) {
      return tokens["token"] != "" && ref.watch(isLoggedInProvider);
    },
    error: (e, s) {
      return false;
    },
    loading: () {
      return true;
    },
  );
});

final idProvider = Provider((ref) {
  // return "";
  return ref.watch(authTokenProvider).when(
    data: (tokens) {
      return tokens["token"] == ""
          ? null
          : JwtDecoder.decode(tokens["token"] as String)["sub"];
    },
    error: (e, s) {
      return null;
    },
    loading: () {
      return null;
    },
  );
});

final tokenProvider = Provider((ref) {
  // return "dxfcgvhjk";
  return ref.watch(authTokenProvider).when(
    data: (tokens) {
      return tokens["token"] as String;
    },
    error: (e, s) {
      return "";
    },
    loading: () {
      return "";
    },
  );
});

class OpenIdTokenProvider
    extends StateNotifier<AsyncValue<Map<String, String>>> {
  FlutterAppAuth appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Base64Codec base64 = const Base64Codec.urlSafe();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  final String titanRedirectUrl = "titan://myecl.fr/account/activate";
  final String redirectUrl = "http://localhost:54383/static.html";
  final String discoveryUrl =
      "${Repository.host}.well-known/openid-configuration";
  final List<String> scopes = ["API"];
  OpenIdTokenProvider() : super(const AsyncValue.loading());

  Future getTokenFromRequest() async {
    html.WindowBase? popupWin;

    String generateRandomString(int len) {
      var r = Random.secure();
      const chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => chars[r.nextInt(chars.length)])
          .join();
    }

    String hash(String data) {
      return base64.encode(sha256.convert(utf8.encode(data)).bytes);
    }

    final currentUri = Uri.base;

    final redirectUri = Uri(
      host: currentUri.host,
      scheme: currentUri.scheme,
      port: currentUri.port,
      path: '/static.html',
    );
    final codeVerifier = generateRandomString(128);

    final authUrl =
        "${Repository.host}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectUri&code_challenge=${hash(codeVerifier)}&code_challenge_method=S256";

    state = const AsyncValue.loading();
    try {
      if (kIsWeb) {
        popupWin = html.window
            .open(authUrl, "Hyperion", "width=800, height=900, scrollbars=yes");

        void login(String data) async {
          final receivedUri = Uri.parse(data);
          final token = receivedUri.queryParameters["code"];
          print('token $token');
          if (popupWin != null) {
            popupWin!.close();
            popupWin = null;
          }
          var body = {
            "client_id": clientId,
            "code": token,
            "redirect_uri": redirectUri.toString(),
            "code_verifier": codeVerifier,
            "grant_type": "authorization_code",
          };
          print('codeVerifier: $codeVerifier');
          print("hash: ${hash(codeVerifier)}");
          final Map<String, String> headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Accept": "application/json",
          };
          try {
            if (token != null && token.isNotEmpty) {
              final response = await http
                  .post(Uri.parse("${Repository.host}auth/token"),
                      headers: headers, body: body)
                  .timeout(const Duration(seconds: 5));
              if (response.statusCode == 200) {
                final token = jsonDecode(response.body)["access_token"];
                final refreshToken = jsonDecode(response.body)["refresh_token"];
                await _secureStorage.write(key: tokenName, value: refreshToken);
                state = AsyncValue.data({
                  tokenKey: token,
                  refreshTokenKey: refreshToken,
                });
              } else {
                throw Exception('Wrong credentials');
              }
            } else {
              print("empty token");
            }
          } on TimeoutException catch (_) {
            throw Exception('No response from server');
          } catch (e) {
            rethrow;
          }
        }

        /// Listen to message send with `postMessage`.
        html.window.onMessage.listen((event) {
          /// If the event contains the token it means the user is authenticated.
          if (event.data.toString().contains('code=')) {
            login(event.data);
          }
        });
      } else {
        AuthorizationTokenResponse? resp =
            await appAuth.authorizeAndExchangeCode(
          AuthorizationTokenRequest(
            clientId,
            redirectUrl,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
          ),
        );
        if (resp != null) {
          await _secureStorage.write(key: tokenName, value: resp.refreshToken);
          state = AsyncValue.data({
            tokenKey: resp.accessToken!,
            refreshTokenKey: resp.refreshToken!,
          });
        } else {
          state = const AsyncValue.error("Error");
        }
      }
    } catch (e) {
      state = AsyncValue.error("Error $e");
    }
  }

  void getTokenFromStorage() {
    state = const AsyncValue.loading();
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          final resp = await appAuth.token(TokenRequest(
            clientId,
            redirectUrl,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
            refreshToken: token,
          ));
          if (resp != null) {
            state = AsyncValue.data({
              tokenKey: resp.accessToken!,
              refreshTokenKey: resp.refreshToken!,
            });
            storeToken();
          } else {
            state = const AsyncValue.error("Error");
            deleteToken();
          }
        } catch (e) {
          state = AsyncValue.error(e);
          deleteToken();
        }
      } else {
        state = const AsyncValue.error("No token found");
        deleteToken();
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
        state = AsyncValue.data({
          tokenKey: resp.accessToken!,
          refreshTokenKey: resp.refreshToken!,
        });
      } else {
        state = const AsyncValue.error("Error");
      }
    });
  }

  Future<bool> refreshToken() async {
    return state.when(
      data: (token) async {
        try {
          TokenResponse? resp = await appAuth.token(
            TokenRequest(
              clientId,
              redirectUrl,
              discoveryUrl: discoveryUrl,
              scopes: scopes,
              refreshToken: token[refreshTokenKey] as String,
            ),
          );
          if (resp != null) {
            state = AsyncValue.data({
              tokenKey: resp.accessToken!,
              refreshTokenKey: resp.refreshToken!,
            });
            storeToken();
            return true;
          } else {
            state = const AsyncValue.error("Error");
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        return false;
      },
    );
  }

  void storeToken() {
    state.when(
        data: (tokens) => _secureStorage.write(
            key: tokenName, value: tokens[refreshTokenKey]),
        error: (e, s) {
          throw e;
        },
        loading: () {
          throw Exception("Token is not loaded");
        });
  }

  void deleteToken() {
    try {
      _secureStorage.delete(key: tokenName);
      state = AsyncValue.data({tokenKey: "", refreshTokenKey: ""});
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
