import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myecl/tools/repository/repository.dart';

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
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  final String redirectUrl = "titan://validate";
  final String discoveryUrl =
      "${Repository.host}.well-known/openid-configuration";
  final List<String> scopes = ["API"];
  OpenIdTokenProvider() : super(const AsyncValue.loading());

  Future getTokenFromRequest() async {
    state = const AsyncValue.loading();
    try {
      if (kIsWeb) {
        final result = await FlutterWebAuth.authenticate(
            url:
                "${Repository.host}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}",
            callbackUrlScheme: redirectUrl);
        final token = Uri.parse(result).queryParameters[tokenKey];
        final refreshToken = Uri.parse(result).queryParameters[refreshTokenKey];
        await _secureStorage.write(key: tokenName, value: refreshToken);
        state = AsyncValue.data({
          tokenKey: token!,
          refreshTokenKey: refreshToken!,
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
