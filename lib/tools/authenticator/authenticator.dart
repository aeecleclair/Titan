import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/repository/auth_repository.dart';

class AppAuthenticator implements Authenticator {
  AppAuthenticator({required this.repo});

  final AuthRepository repo;

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    debugPrint(
      '[AppAuthenticator] response.statusCode: ${response.statusCode}',
    );
    debugPrint(
      '[AppAuthenticator] request Retry-Count: ${request.headers['Retry-Count'] ?? 0}',
    );

    // 401
    if (response.statusCode == HttpStatus.unauthorized) {
      // Trying to update token only 1 time
      if (request.headers['Retry-Count'] != null) {
        debugPrint(
          '[AppAuthenticator] Unable to refresh token, retry count exceeded',
        );
        return null;
      }

      try {
        final newToken = await _refreshToken();

        return applyHeaders(
          request,
          {
            HttpHeaders.authorizationHeader: newToken,
            // Setting the retry count to not end up in an infinite loop
            // of unsuccessful updates
            'Retry-Count': '1',
          },
        );
      } catch (e) {
        debugPrint('[AppAuthenticator] Unable to refresh token: $e');
        return null;
      }
    }

    return null;
  }

  // Completer to prevent multiple token refreshes at the same time
  Completer<String>? _completer;

  Future<String> _refreshToken() {
    var completer = _completer;
    if (completer != null && !completer.isCompleted) {
      debugPrint('Token refresh is already in progress');
      return completer.future;
    }

    completer = Completer<String>();
    _completer = completer;

    repo.refreshToken().then((response) {
      debugPrint('[AppAuthenticator] Refreshed token');
      // Completing with a new token
      completer?.complete(response.accessToken);
    }).onError((error, stackTrace) {
      // Completing with an error
      completer?.completeError(error ?? 'Refresh token error', stackTrace);
    });

    return completer.future;
  }

  @override
  AuthenticationCallback? get onAuthenticationFailed => null;

  @override
  AuthenticationCallback? get onAuthenticationSuccessful => null;
}

final authenticatorProvider = Provider<AppAuthenticator>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AppAuthenticator(repo: repo);
});
