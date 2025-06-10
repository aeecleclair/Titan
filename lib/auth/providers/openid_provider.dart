import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:titan/auth/providers/is_connected_provider.dart';
import 'package:titan/auth/repository/openid_repository.dart';
import 'package:titan/tools/cache/cache_manager.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';
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
      },
    );

class IsLoggedInProvider extends StateNotifier<bool> {
  IsLoggedInProvider(super.b);

  void refresh(AsyncValue<Map<String, String>> token) {
    state = token.maybeWhen(
      data: (tokens) => tokens["token"] == ""
          ? false
          : !JwtDecoder.isExpired(tokens["token"] as String),
      orElse: () => false,
    );
  }
}

class IsCachingProvider extends StateNotifier<bool> {
  IsCachingProvider(super.b);

  void set(bool b) {
    state = b;
  }
}

final isCachingProvider = StateNotifierProvider<IsCachingProvider, bool>((ref) {
  final IsCachingProvider isCachingProvider = IsCachingProvider(false);

  final isConnected = ref.watch(isConnectedProvider);
  CacheManager().readCache("id").then((value) {
    isCachingProvider.set(!isConnected && value != "");
  });
  return isCachingProvider;
});

final isLoggedInProvider = StateNotifierProvider<IsLoggedInProvider, bool>((
  ref,
) {
  final IsLoggedInProvider isLoggedInProvider = IsLoggedInProvider(false);

  final isConnected = ref.watch(isConnectedProvider);
  final authToken = ref.watch(authTokenProvider);
  final isCaching = ref.watch(isCachingProvider);
  if (isConnected) {
    isLoggedInProvider.refresh(authToken);
  } else if (isCaching) {
    return IsLoggedInProvider(true);
  }
  return isLoggedInProvider;
});

final loadingProvider = FutureProvider<bool>((ref) {
  final isCaching = ref.watch(isCachingProvider);
  return isCaching ||
      ref
          .watch(authTokenProvider)
          .when(
            data: (tokens) =>
                tokens["token"] != "" && ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
          );
});

final idProvider = FutureProvider<String>((ref) {
  final cacheManager = CacheManager();
  return ref
      .watch(authTokenProvider)
      .when(
        data: (tokens) {
          final id = tokens["token"] == ""
              ? ""
              : JwtDecoder.decode(tokens["token"] as String)["sub"];
          cacheManager.writeCache("id", id);
          return id;
        },
        error: (e, s) => "",
        loading: () => cacheManager.readCache("id"),
      );
});

final tokenProvider = Provider((ref) {
  return ref
      .watch(authTokenProvider)
      .maybeWhen(data: (tokens) => tokens["token"] as String, orElse: () => "");
});

class OpenIdTokenProvider
    extends StateNotifier<AsyncValue<Map<String, String>>> {
  FlutterAppAuth appAuth = const FlutterAppAuth();
  final CacheManager cacheManager = CacheManager();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Base64Codec base64 = const Base64Codec.urlSafe();
  final OpenIdRepository openIdRepository = OpenIdRepository();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  final String redirectURLScheme = "${getTitanPackageName()}://authorized";
  final String redirectURL = "${getTitanURL()}/static.html";
  final String discoveryUrl =
      "${Repository.host}.well-known/openid-configuration";
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
    final codeVerifier = generateRandomString(128);

    final authUrl =
        "${Repository.host}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectURL&code_challenge=${hash(codeVerifier)}&code_challenge_method=S256";

    state = const AsyncValue.loading();
    try {
      if (kIsWeb) {
        popupWin = html.window.open(
          authUrl,
          "Hyperion",
          "width=800, height=900, scrollbars=yes",
        );

        final completer = Completer();
        void checkWindowClosed() {
          if (popupWin != null && popupWin!.closed == true) {
            completer.complete();
          } else {
            Future.delayed(
              const Duration(milliseconds: 100),
              checkWindowClosed,
            );
          }
        }

        checkWindowClosed();
        completer.future.then((_) {
          state.maybeWhen(
            loading: () {
              state = AsyncValue.data({tokenKey: "", refreshTokenKey: ""});
            },
            orElse: () {},
          );
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
              final resp = await openIdRepository.getToken(
                token,
                clientId,
                redirectURL.toString(),
                codeVerifier,
                "authorization_code",
              );
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
        AuthorizationTokenResponse resp = await appAuth
            .authorizeAndExchangeCode(
              AuthorizationTokenRequest(
                clientId,
                redirectURLScheme,
                discoveryUrl: discoveryUrl,
                scopes: scopes,
                allowInsecureConnections: kDebugMode,
              ),
            );
        await _secureStorage.write(key: tokenName, value: resp.refreshToken);
        state = AsyncValue.data({
          tokenKey: resp.accessToken!,
          refreshTokenKey: resp.refreshToken!,
        });
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
              token,
              clientId,
              "",
              "",
              refreshTokenKey,
            );
            final accessToken = resp[tokenKey]!;
            final refreshToken = resp[refreshTokenKey]!;
            await _secureStorage.write(key: tokenName, value: refreshToken);
            state = AsyncValue.data({
              tokenKey: accessToken,
              refreshTokenKey: refreshToken,
            });
          } else {
            final resp = await appAuth.token(
              TokenRequest(
                clientId,
                redirectURLScheme,
                discoveryUrl: discoveryUrl,
                scopes: scopes,
                refreshToken: token,
                allowInsecureConnections: kDebugMode,
              ),
            );
            state = AsyncValue.data({
              tokenKey: resp.accessToken!,
              refreshTokenKey: resp.refreshToken!,
            });
            storeToken();
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
        .token(
          TokenRequest(
            clientId,
            redirectURLScheme,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
            authorizationCode: authorizationToken,
            allowInsecureConnections: kDebugMode,
          ),
        )
        .then((resp) {
          state = AsyncValue.data({
            tokenKey: resp.accessToken!,
            refreshTokenKey: resp.refreshToken!,
          });
        });
  }

  Future<bool> refreshToken() async {
    return state.when(
      data: (token) async {
        if (token[refreshTokenKey] != null && token[refreshTokenKey] != "") {
          TokenResponse? resp = await appAuth.token(
            TokenRequest(
              clientId,
              redirectURLScheme,
              discoveryUrl: discoveryUrl,
              scopes: scopes,
              refreshToken: token[refreshTokenKey] as String,
              allowInsecureConnections: kDebugMode,
            ),
          );
          state = AsyncValue.data({
            tokenKey: resp.accessToken!,
            refreshTokenKey: resp.refreshToken!,
          });
          storeToken();
          return true;
        }
        state = const AsyncValue.error(e, StackTrace.empty);
        return false;
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
      data: (tokens) =>
          _secureStorage.write(key: tokenName, value: tokens[refreshTokenKey]),
      error: (e, s) {
        throw e;
      },
      loading: () {
        throw Exception("Token is not loaded");
      },
    );
  }

  void deleteToken() {
    try {
      _secureStorage.delete(key: tokenName);
      cacheManager.deleteCache(tokenName);
      cacheManager.deleteCache("id");
      state = AsyncValue.data({tokenKey: "", refreshTokenKey: ""});
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}
