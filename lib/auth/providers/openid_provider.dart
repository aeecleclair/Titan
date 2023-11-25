import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:myecl/auth/providers/is_connected_provider.dart';
import 'package:myecl/auth/repository/auth_repository.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/cache/cache_manager.dart';

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<TokenResponse>>(
        (ref) {
  OpenIdTokenProvider openIdTokenProvider = OpenIdTokenProvider();
  final isConnected = ref.watch(isConnectedProvider);
  if (isConnected) {
    openIdTokenProvider.getTokenFromStorage();
  }
  return openIdTokenProvider;
});

class IsLoggedInProvider extends StateNotifier<bool> {
  IsLoggedInProvider(super.b);

  void refresh(AsyncValue<TokenResponse> token) {
    state = token.maybeWhen(
      data: (tokens) => tokens.accessToken == ""
          ? false
          : !JwtDecoder.isExpired(tokens.accessToken),
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
  CacheManager().readCache("id").then(
    (value) {
      isCachingProvider.set(!isConnected && value != "");
    },
  );
  return isCachingProvider;
});

final isLoggedInProvider =
    StateNotifierProvider<IsLoggedInProvider, bool>((ref) {
  final IsLoggedInProvider isLoggedInProvider = IsLoggedInProvider(false);

  final isConnected = ref.watch(isConnectedProvider);
  final authToken = ref.watch(authTokenProvider);
  final isCaching = ref.watch(isCachingProvider);
  if (isConnected) {
    isLoggedInProvider.refresh(authToken);
  } else if (isCaching) {
    return IsLoggedInProvider(false);
  }
  return isLoggedInProvider;
});

final loadingProvider = FutureProvider<bool>((ref) {
  final isCaching = ref.watch(isCachingProvider);
  return isCaching ||
      ref.watch(authTokenProvider).when(
            data: (tokens) =>
                tokens.accessToken != "" && ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
          );
});

final idProvider = FutureProvider<String>((ref) {
  final cacheManager = CacheManager();
  return ref.watch(authTokenProvider).when(
        data: (tokens) {
          final id = tokens.accessToken == ""
              ? ""
              : JwtDecoder.decode(tokens.accessToken)["sub"];
          cacheManager.writeCache("id", id);
          return id;
        },
        error: (e, s) => "",
        loading: () => cacheManager.readCache("id"),
      );
});

final tokenProvider = Provider((ref) {
  return ref.watch(authTokenProvider).maybeWhen(
        data: (tokens) => tokens.accessToken,
        orElse: () => "",
      );
});

class OpenIdTokenProvider
    extends StateNotifier<AsyncValue<TokenResponse>> {
  FlutterAppAuth appAuth = const FlutterAppAuth();
  final CacheManager cacheManager = CacheManager();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Base64Codec base64 = const Base64Codec.urlSafe();
  final OpenIdRepository openIdRepository = OpenIdRepository();
  final String tokenName = "my_ecl_auth_token";
  final String clientId = "Titan";
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  final String redirectUrl = "${getTitanPackageName()}://authorized";
  final String redirectUrlHost = "myecl.fr";
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
    state = const AsyncValue.loading();
    final tokenResponse = await userRepository!.getTokenFromRequest();
    if (tokenResponse.accessToken != "") {
      state = AsyncValue.data(tokenResponse);
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future getTokenFromStorage() async {
    state = const AsyncValue.loading();
    final tokenResponse = await userRepository!.getTokenFromStorage();
    if (tokenResponse.accessToken != "") {
      state = AsyncValue.data(tokenResponse);
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future<void> getAuthToken(String authorizationToken) async {
    state = const AsyncValue.loading();
    final tokenResponse =
        await userRepository!.getAuthToken(authorizationToken);
    if (tokenResponse.accessToken != "") {
      state = AsyncValue.data(tokenResponse);
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future<bool> refreshToken() async {
    state = const AsyncValue.loading();
    final tokenResponse = await userRepository!.refreshToken();
    if (tokenResponse.accessToken != "") {
      state = AsyncValue.data(tokenResponse);
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
    return tokenResponse.accessToken != "";
  }

  void deleteToken() => userRepository!.deleteToken();
}
