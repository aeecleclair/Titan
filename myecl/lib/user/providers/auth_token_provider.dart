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
  AuthTokenProvider() : super(const AsyncValue.loading());

  void getTokenFromRequest(String username, String password) async {
    try {
      final token = await _authTokenRepository.getToken(username, password);
      state = AsyncValue.data(token);
      lastToken = token;
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void getTokenFromStorage() {
    _secureStorage.read(key: tokenName).then((token) {
      if (token != null) {
        state = AsyncValue.data(token);
        lastToken = token;
      } else {
        state = AsyncValue.error(Exception("No token in storage"));
      }
    });
  }

  void storeToken() {
    _secureStorage.write(key: tokenName, value: lastToken);
  }

  Future<bool> souldRefreshToken() async {
    return state.when(
      data: (token) {
        return JwtDecoder.isExpired(token);
      },
      error: (e, s) {
        return true;
      },
      loading: () {
        return true;
      },
    );
  }
}
