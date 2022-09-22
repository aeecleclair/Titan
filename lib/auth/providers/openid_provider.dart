import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myecl/auth/repositories/oauth2_repositoty.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

final authTokenProvider =
    StateNotifierProvider<OAuth2TokenProvider, AsyncValue<Map<String, String>>>(
        (ref) {
  OAuth2TokenProvider oauth2TokenRepository = OAuth2TokenProvider();
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

class OAuth2TokenProvider
    extends StateNotifier<AsyncValue<Map<String, String>>> {
  FlutterAppAuth appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String redirectUrl = "titan://myecl.fr/account/activate";
  final String discoveryUrl =
      "https://hyperion.myecl.fr/.well-known/openid-configuration";
  final List<String> scopes = ["API"];
  OAuth2TokenProvider() : super(const AsyncValue.loading());

  Future getTokenFromRequest(String username, String password) async {
    state = const AsyncValue.loading();
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
      state = AsyncValue.data({
        "token": resp.accessToken!,
        "refreshToken": resp.refreshToken!,
      });
    } else {
      state = const AsyncValue.error("Error");
    }
  }

  void getTokenFromStorage() {
    state = const AsyncValue.loading();
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          appAuth
              .token(TokenRequest(
            clientId,
            redirectUrl,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
            refreshToken: token,
          ))
              .then((resp) {
            if (resp != null) {
              state = AsyncValue.data({
                "token": resp.accessToken!,
                "refreshToken": resp.refreshToken!,
              });
            } else {
              state = const AsyncValue.error("Error");
            }
          });
          storeToken();
        } catch (e) {
          state = AsyncValue.error(e);
        }
      } else {
        deleteToken();
        state = const AsyncValue.error("No token found");
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
              refreshToken: token["refreshToken"] as String,
            ),
          );
          if (resp != null) {
            state = AsyncValue.data({
              "token": resp.accessToken!,
              "refreshToken": resp.refreshToken!,
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
        data: (tokens) =>
            _secureStorage.write(key: tokenName, value: tokens["refreshToken"]),
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
      state = const AsyncValue.data({"token": "", "refreshToken": ""});
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
