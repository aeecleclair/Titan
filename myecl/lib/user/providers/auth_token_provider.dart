import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authTokenProvider =
    StateNotifierProvider<AuthTokenProvider, AsyncValue<String>>((ref) {
  AuthTokenProvider _authProvider = AuthTokenProvider();
  _authProvider.getTokenFromStorage();
  return _authProvider;
});

final isLoggedInProvider = Provider((ref) {
  return ref.watch(authTokenProvider).when(
    data: (token) {
      return token.isEmpty ? false : !JwtDecoder.isExpired(token);
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
  return ref.watch(authTokenProvider).when(
    data: (token) {
      return token.isNotEmpty;
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
  return ref.watch(authTokenProvider).when(
    data: (token) {
      return token.isEmpty ? null : JwtDecoder.decode(token)["sub"];
    },
    error: (e, s) {
      return null;
    },
    loading: () {
      return null;
    },
  );
});

class AuthTokenProvider extends StateNotifier<AsyncValue<String>> {
  final _authTokenRepository = AuthTokenRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String tokenName = "my_ecl_auth_token";
  AuthTokenProvider() : super(const AsyncValue.loading());

  Future<AsyncValue> getTokenFromRequest(
      String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final token = await _authTokenRepository.getToken(username, password);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  void getTokenFromStorage() {
    state = const AsyncValue.loading();
    _secureStorage.read(key: tokenName).then((token) {
      if (token != null) {
        state = AsyncValue.data(token);
      } else {
        state = AsyncValue.error(Exception("No token in storage"));
      }
    });
  }

  void storeToken() {
    // ! Pour les tests, il faut décommenter la ligne suivante à la fin
    state.when(
        data: (token) => _secureStorage.write(key: tokenName, value: token),
        error: (e, s) {
          print("Error while storing token");
        },
        loading: () {
          print("Loading while storing token");
        });
  }

  void deleteToken() {
    try {
      _secureStorage.delete(key: tokenName);
      state = const AsyncValue.data("");
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
