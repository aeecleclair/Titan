import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/is_connected_provider.dart';
import 'package:myecl/auth/repository/auth_repository.dart';
import 'package:myecl/generated/openapi.models.swagger.dart' show TokenResponse;
import 'package:myecl/tools/cache/cache_manager.dart';

final authTokenProvider =
    StateNotifierProvider<OpenIdTokenProvider, AsyncValue<TokenResponse>>(
        (ref) {
  final repository = ref.watch(authRepositoryProvider);
  final openIdTokenProvider = OpenIdTokenProvider(userRepository: repository);
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

class OpenIdTokenProvider extends StateNotifier<AsyncValue<TokenResponse>> {
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  AuthRepository? userRepository;
  OpenIdTokenProvider({required this.userRepository})
      : super(const AsyncValue.loading());

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
