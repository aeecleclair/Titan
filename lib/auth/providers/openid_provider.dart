import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:myecl/auth/class/auth_request.dart';
import 'package:myecl/auth/class/auth_token.dart';
import 'package:myecl/auth/providers/is_connected_provider.dart';
import 'package:myecl/auth/repository/openid_repository.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<AuthToken>>((ref) {
      OpenIdTokenProvider openIdTokenProvider = OpenIdTokenProvider();
      final isConnected = ref.watch(isConnectedProvider);
      if (isConnected) {
        openIdTokenProvider.getTokenFromStorage();
      }
      return openIdTokenProvider;
    });

class IsLoggedInProvider extends StateNotifier<bool> {
  IsLoggedInProvider(super.b);

  void refresh(AsyncValue<AuthToken> asyncAuthToken) {
    state = asyncAuthToken.maybeWhen(
      data: (authToken) => authToken.accessToken == ""
          ? false
          : !JwtDecoder.isExpired(authToken.accessToken),
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
            data: (authToken) =>
                authToken.accessToken != "" && ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
          );
});

final idProvider = FutureProvider<String>((ref) {
  final cacheManager = CacheManager();
  return ref
      .watch(authTokenProvider)
      .when(
        data: (authToken) {
          final id = authToken.accessToken == ""
              ? ""
              : JwtDecoder.decode(authToken.accessToken)["sub"];
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
      .maybeWhen(data: (authToken) => authToken.accessToken, orElse: () => "");
});

class OpenIdTokenProvider extends StateNotifier<AsyncValue<AuthToken>> {
  FlutterAppAuth appAuth = const FlutterAppAuth();
  final CacheManager cacheManager = CacheManager();
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static Base64Codec base64 = const Base64Codec.urlSafe();
  static OpenIdRepository openIdRepository = OpenIdRepository();
  static const String tokenName = "my_ecl_auth_token";
  static const String clientId = "Titan";
  static const String tokenKey = "token";
  static const String refreshTokenKey = "refresh_token";
  static String redirectURLScheme = "${getTitanPackageName()}://authorized";
  static String redirectURL = "${getTitanURL()}/static.html";
  static String discoveryUrl =
      "${Repository.host}.well-known/openid-configuration";
  static List<String> scopes = ["API"];

  OpenIdTokenProvider() : super(const AsyncLoading());

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

    state = const AsyncLoading();
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
              state = AsyncData(AuthToken.empty());
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
              final authToken = await openIdRepository.getToken(
                AuthRequest(
                  token: token,
                  clientId: clientId,
                  redirectUri: redirectURL,
                  codeVerifier: codeVerifier,
                  grantType: AuthGrantType.authorizationCode,
                ),
              );
              await _secureStorage.write(
                key: tokenName,
                value: authToken.refreshToken,
              );

              state = AsyncData(authToken);
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

        state = AsyncData(
          AuthToken(
            accessToken: resp.accessToken!,
            refreshToken: resp.refreshToken!,
          ),
        );
      }
    } catch (e) {
      state = AsyncError("Error $e", StackTrace.empty);
    }
  }

  Future getTokenFromStorage() async {
    state = const AsyncLoading();
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          if (kIsWeb) {
            final authToken = await openIdRepository.getToken(
              AuthRequest(
                token: token,
                clientId: clientId,
                redirectUri: redirectURL,
                codeVerifier: "",
                grantType: AuthGrantType.refreshToken,
              ),
            );
            await _secureStorage.write(
              key: tokenName,
              value: authToken.refreshToken,
            );
            state = AsyncData(authToken);
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
            state = AsyncData(
              AuthToken(
                accessToken: resp.accessToken!,
                refreshToken: resp.refreshToken!,
              ),
            );

            storeToken();
          }
        } catch (e) {
          state = AsyncError(e, StackTrace.empty);
        }
      } else {
        state = const AsyncError("No token found", StackTrace.empty);
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
          state = AsyncData(
            AuthToken(
              accessToken: resp.accessToken!,
              refreshToken: resp.refreshToken!,
            ),
          );
        });
  }

  Future<bool> refreshToken() async {
    return state.when(
      data: (authToken) async {
        if (authToken.refreshToken != "") {
          TokenResponse? resp = await appAuth.token(
            TokenRequest(
              clientId,
              redirectURLScheme,
              discoveryUrl: discoveryUrl,
              scopes: scopes,
              refreshToken: authToken.refreshToken,
              allowInsecureConnections: kDebugMode,
            ),
          );
          state = AsyncData(
            AuthToken(
              accessToken: resp.accessToken!,
              refreshToken: resp.refreshToken!,
            ),
          );
          storeToken();
          return true;
        }
        state = const AsyncError(e, StackTrace.empty);
        return false;
      },
      error: (error, stackTrace) {
        state = AsyncError(error, stackTrace);
        return false;
      },
      loading: () {
        return false;
      },
    );
  }

  void storeToken() {
    state.when(
      data: (authToken) =>
          _secureStorage.write(key: tokenName, value: authToken.refreshToken),
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
      state = AsyncData(AuthToken.empty());
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
    }
  }
}
