import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/is_connected_provider.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/repository/auth_repository.dart';

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<Map<String, String>>>(
        (ref) {
  final repository = ref.watch(authRepositoryProvider);
  print(repository.tokenResponse);
  final openIdTokenProvider = OpenIdTokenProvider(userRepository: repository);
  final isConnected = ref.watch(isConnectedProvider);
  print('isConnected: $isConnected');
  if (isConnected) {
    openIdTokenProvider.getTokenFromStorage();
  }
  return openIdTokenProvider;
});

class IsLoggedInProvider extends StateNotifier<bool> {
  IsLoggedInProvider(bool b) : super(b);

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
  IsCachingProvider(bool b) : super(b);

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
                tokens["token"] != "" && ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
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
        error: (e, s) => "",
        loading: () => cacheManager.readCache("id"),
      );
});

final tokenProvider = Provider((ref) {
  return ref.watch(authTokenProvider).maybeWhen(
        data: (tokens) => tokens["token"] as String,
        orElse: () => "",
      );
});

class OpenIdTokenProvider
    extends StateNotifier<AsyncValue<Map<String, String>>> {
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  AuthRepository? userRepository;
  OpenIdTokenProvider({required this.userRepository})
      : super(const AsyncValue.loading());

  Future getTokenFromRequest() async {
    print("getTokenFromRequest");
    state = const AsyncValue.loading();
    print("loafing");
    await userRepository!.getTokenFromRequest();
    print('token: ${userRepository!.tokenResponse.accessToken}');
    if (userRepository!.tokenResponse.accessToken != "") {
      state = AsyncValue.data({
        tokenKey: userRepository!.tokenResponse.accessToken,
        refreshTokenKey: userRepository!.tokenResponse.refreshToken,
      });
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future getTokenFromStorage() async {
    print("getTokenFromStorage");
    state = const AsyncValue.loading();
    print(userRepository);
    await userRepository!.getTokenFromStorage();
    if (userRepository!.tokenResponse.accessToken != "") {
      state = AsyncValue.data({
        tokenKey: userRepository!.tokenResponse.accessToken,
        refreshTokenKey: userRepository!.tokenResponse.refreshToken,
      });
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future<void> getAuthToken(String authorizationToken) async {
    state = const AsyncValue.loading();
    await userRepository!.getAuthToken(authorizationToken);
    if (userRepository!.tokenResponse.accessToken != "") {
      state = AsyncValue.data({
        tokenKey: userRepository!.tokenResponse.accessToken,
        refreshTokenKey: userRepository!.tokenResponse.refreshToken,
      });
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
  }

  Future<bool> refreshToken() async {
    state = const AsyncValue.loading();
    final response = await userRepository!.refreshToken();
    if (userRepository!.tokenResponse.accessToken != "") {
      state = AsyncValue.data({
        tokenKey: userRepository!.tokenResponse.accessToken,
        refreshTokenKey: userRepository!.tokenResponse.refreshToken,
      });
    } else {
      state = const AsyncValue.error("Error", StackTrace.empty);
    }
    return response;
  }

  void storeToken() => userRepository!.storeToken();

  void deleteToken() => userRepository!.deleteToken();
}
