import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/is_connected_provider.dart';
import 'package:titan/auth/repository/auth_repository.dart';
import 'package:titan/tools/cache/cache_manager.dart';
import 'package:titan/generated/openapi.models.swagger.dart' as models;

final authTokenProvider =
    NotifierProvider<OpenIdTokenProvider, AsyncValue<models.TokenResponse>>(
      OpenIdTokenProvider.new,
    );

class IsLoggedInProvider extends Notifier<bool> {
  @override
  bool build() {
    final isConnected = ref.watch(isConnectedProvider);
    final authToken = ref.watch(authTokenProvider);
    final isCaching = ref.watch(isCachingProvider);

    if (isConnected) {
      refresh(authToken);
    } else if (isCaching) {
      return true;
    }

    return false;
  }

  void refresh(AsyncValue<models.TokenResponse> token) {
    state = token.maybeWhen(
      data: (tokens) => !JwtDecoder.isExpired(tokens.accessToken),
      orElse: () => false,
    );
  }
}

class IsCachingProvider extends Notifier<bool> {
  @override
  bool build() {
    final isConnected = ref.watch(isConnectedProvider);
    CacheManager().readCache("id").then((value) {
      set(!isConnected && value != "");
    });
    return false;
  }

  void set(bool b) {
    state = b;
  }
}

final isCachingProvider = NotifierProvider<IsCachingProvider, bool>(
  IsCachingProvider.new,
);

final isLoggedInProvider = NotifierProvider<IsLoggedInProvider, bool>(
  IsLoggedInProvider.new,
);

final loadingProvider = FutureProvider<bool>((ref) {
  final isCaching = ref.watch(isCachingProvider);
  return isCaching ||
      ref
          .watch(authTokenProvider)
          .when(
            data: (tokens) => ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
          );
});

final idProvider = FutureProvider<String>((ref) {
  final cacheManager = CacheManager();
  return ref
      .watch(authTokenProvider)
      .when(
        data: (tokens) {
          final id = JwtDecoder.decode(tokens.accessToken)["sub"];
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
      .maybeWhen(data: (tokens) => tokens.accessToken, orElse: () => "");
});

class OpenIdTokenProvider extends Notifier<AsyncValue<models.TokenResponse>> {
  final String tokenKey = "token";
  final String refreshTokenKey = "refresh_token";
  OpenIdTokenProvider() : super();

  AuthRepository get userRepository => ref.read(authRepositoryProvider);

  @override
  AsyncValue<models.TokenResponse> build() {
    getTokenFromStorage();
    return const AsyncValue.loading();
  }

  Future getTokenFromRequest() async {
    state = const AsyncValue.loading();
    try {
      final tokenResponse = await userRepository.getTokenFromRequest();
      if (tokenResponse.accessToken != "") {
        state = AsyncValue.data(tokenResponse);
      } else {
        state = const AsyncValue.error("Error", StackTrace.empty);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future getTokenFromStorage() async {
    state = const AsyncValue.loading();
    try {
      final tokenResponse = await userRepository.getTokenFromStorage();
      if (tokenResponse.accessToken != "") {
        state = AsyncValue.data(tokenResponse);
      } else {
        state = const AsyncValue.error("Error", StackTrace.empty);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> getAuthToken(String authorizationToken) async {
    state = const AsyncValue.loading();
    try {
      final tokenResponse = await userRepository.getAuthToken(
        authorizationToken,
      );
      if (tokenResponse.accessToken != "") {
        state = AsyncValue.data(tokenResponse);
      } else {
        state = const AsyncValue.error("Error", StackTrace.empty);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<bool> refreshToken() async {
    state = const AsyncValue.loading();
    try {
      final tokenResponse = await userRepository.refreshToken();
      if (tokenResponse.accessToken != "") {
        state = AsyncValue.data(tokenResponse);
        return true;
      }
      state = const AsyncValue.error("Error", StackTrace.empty);
      return false;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return false;
    }
  }

  void deleteToken() => userRepository.deleteToken();
}
