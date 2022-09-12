import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myecl/auth/repositories/oauth2_repositoty.dart';

final authTokenProvider =
    StateNotifierProvider<OAuth2TokenProvider, AsyncValue<Map<String, String>>>(
        (ref) {
  OAuth2TokenProvider _oauth2TokenRepository = OAuth2TokenProvider();
  _oauth2TokenRepository.getTokenFromStorage();
  return _oauth2TokenRepository;
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
  final _authTokenRepository = OAuth2TokenRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String tokenName = "my_ecl_auth_token";
  OAuth2TokenProvider() : super(const AsyncValue.loading());

  Future<String> getAuthPageUrl() async {
    return await _authTokenRepository.getLogInPage();
  }

  Future getTokenFromRequest(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final authorizationCode =
          await _authTokenRepository.authorizationFlow(username, password);
      final tokens = await _authTokenRepository.getTokens(authorizationCode);
      state = AsyncValue.data(tokens);
      storeToken();
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void getTokenFromStorage() {
    state = const AsyncValue.loading();
    _secureStorage.read(key: tokenName).then((token) async {
      if (token != null) {
        try {
          final tokens = await _authTokenRepository.refreshTokens(token);
          state = AsyncValue.data(tokens);
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
        final tokens = await _authTokenRepository
            .refreshTokens(token["refreshToken"] as String);
        state = AsyncValue.data(tokens);
        storeToken();
        return true;
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
