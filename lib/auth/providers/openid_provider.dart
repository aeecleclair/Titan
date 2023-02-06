import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myecl/auth/providers/is_connected_provider.dart';
import 'package:myecl/auth/repository/openid_repository.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<Map<String, String>>>(
        (ref) {
  OpenIdTokenProvider openIdTokenProvider = OpenIdTokenProvider();
  final isConnected = ref.watch(isConnectedProvider);
  if (isConnected) {
    openIdTokenProvider.getTokenFromStorage();
  }
  return openIdTokenProvider;
});

class IsLoggedInProvider extends StateNotifier<bool> {
  IsLoggedInProvider(bool b) : super(b);

  void refresh(AsyncValue<Map<String, String>> token) {
    state = token.when(
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
  }
}

final isCachingProvider = FutureProvider<bool>((ref) async {
  final isConnected = ref.watch(isConnectedProvider);
  final id = await CacheManager().readCache("id");
  return !isConnected && id != "";
});

final isLoggedInProvider =
    StateNotifierProvider<IsLoggedInProvider, bool>((ref) {
  final IsLoggedInProvider isLoggedInProvider = IsLoggedInProvider(false);

  final isConnected = ref.watch(isConnectedProvider);
  final authToken = ref.watch(authTokenProvider);
  final isCaching = ref.watch(isCachingProvider);
  if (isConnected) {
    isLoggedInProvider.refresh(authToken);
  } else if (isCaching.when(
      data: (data) => data, error: (e, s) => false, loading: () => false)) {
    return IsLoggedInProvider(true);
  }
  return isLoggedInProvider;
});

final loadingrovider = FutureProvider<bool>((ref) {
  final isCaching = ref.watch(isCachingProvider);
  return isCaching.when(
          data: (data) => data, error: (e, s) => false, loading: () => true) ||
      ref.watch(authTokenProvider).when(
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

final idProvider = FutureProvider<String>((ref) {
  final cacheManager = CacheManager();
  return ref.watch(authTokenProvider).when(
    data: (tokens) {
      final id = tokens["token"] == ""
          ? ""
          : JwtDecoder.decode(tokens["token"] as String)["sub"];
      cacheManager.writeCache("id", id);
      return id;
    },
    error: (e, s) {
      return "";
    },
    loading: () async {
      return await cacheManager.readCache("id");
    },
  );
});

final tokenProvider = Provider((ref) {
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
  final OpenIdRepository openIdRepository = OpenIdRepository();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  final String redirectUrl = "fr.myecl.titan://authorized";
  final String discoveryUrl =
      "${Repository.displayHost}.well-known/openid-configuration";
  final List<String> scopes = ["API"];
  OpenIdTokenProvider() : super(const AsyncValue.loading());

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

    final currentUri = Uri.base;

    final redirectUri = Uri(
      host: currentUri.host,
      scheme: currentUri.scheme,
      port: currentUri.port,
      path: '/static.html',
    );
    final codeVerifier = generateRandomString(128);

    final authUrl =
        "${Repository.displayHost}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectUri&code_challenge=${hash(codeVerifier)}&code_challenge_method=S256";

    state = const AsyncValue.loading();
    try {
      if (kIsWeb) {
        popupWin = html.window
            .open(authUrl, "Hyperion", "width=800, height=900, scrollbars=yes");

        void login(String data) async {
          final receivedUri = Uri.parse(data);
          final token = receivedUri.queryParameters["code"];
          if (popupWin != null) {
            popupWin!.close();
            popupWin = null;
          }
          try {
            if (token != null && token.isNotEmpty) {
              final resp = await openIdRepository.getToken(token, clientId,
                  redirectUri.toString(), codeVerifier, "authorization_code");
              final accessToken = resp[tokenKey]!;
              final refreshToken = resp[refreshTokenKey]!;
              await _secureStorage.write(key: tokenName, value: refreshToken);
              state = AsyncValue.data({
                tokenKey: accessToken,
                refreshTokenKey: refreshToken,
              });
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
          state = const AsyncValue.error("Error", StackTrace.empty);
        }
      }
    } catch (e) {
      state = AsyncValue.error("Error $e", StackTrace.empty);
    }
  }

  Future getTokenFromStorage() async {
    state = const AsyncValue.loading();
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          if (kIsWeb) {
            final resp = await openIdRepository.getToken(
                token, clientId, "", "", refreshTokenKey);
            final accessToken = resp[tokenKey]!;
            final refreshToken = resp[refreshTokenKey]!;
            await _secureStorage.write(key: tokenName, value: refreshToken);
            state = AsyncValue.data({
              tokenKey: accessToken,
              refreshTokenKey: refreshToken,
            });
          } else {
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
              state = const AsyncValue.error("Error", StackTrace.empty);
            }
          }
        } catch (e) {
          state = AsyncValue.error(e, StackTrace.empty);
        }
      } else {
        state = const AsyncValue.error("No token found", StackTrace.empty);
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
        state = const AsyncValue.error("Error", StackTrace.empty);
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
            state = const AsyncValue.error("Error", StackTrace.empty);
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e, StackTrace.empty);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
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
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}
