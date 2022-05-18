import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authTokenProvider =
    StateNotifierProvider<AuthTokenProvider, AsyncValue<String>>((ref) {
  return AuthTokenProvider();
});

class AuthTokenProvider extends StateNotifier<AsyncValue<String>> {
  final _authTokenRepository = AuthTokenRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String lastToken = "";
  String tokenName = "my_ecl_auth_token";
  bool isLoggedIn = false;
  bool loading = false;
  AuthTokenProvider() : super(const AsyncValue.loading());

  Future<AsyncValue> getTokenFromRequest(String username, String password) async {
    loading = true;
    try {
      final token = await _authTokenRepository.getToken(username, password);
      state = AsyncValue.data(token);
      lastToken = token;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    shouldRefreshToken();
    loading = false;
    return state;
  }

  void getTokenFromStorage() {
    loading = true;
    _secureStorage.read(key: tokenName).then((token) {
      if (token != null) {
        state = AsyncValue.data(token);
        lastToken = token;
      } else {
        state = AsyncValue.error(Exception("No token in storage"));
      }
    });
    shouldRefreshToken();
    loading = false;
  }

  void storeToken() {
    // ! Pour les tests, il faut décommenter la ligne suivante à la fin
    // _secureStorage.write(key: tokenName, value: lastToken);
  }

  void shouldRefreshToken() {
    return state.when(
      data: (token) {
        isLoggedIn = JwtDecoder.isExpired(token);
      },
      error: (e, s) {
        isLoggedIn = true;
      },
      loading: () {
        isLoggedIn = true;
      },
    );
  }
}
