import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myecl/auth/class/auth_token.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';

/// A wrapper for handling token expiration errors in asynchronous functions.
/// It attempts to refresh the token and re-execute the function if the token has expired.
/// This variation is designed for async functions that return a value.
Future<T> tokenExpireWrapper<T>(Ref ref, Future<T> Function() f) async {
  final authToken = ref.read(authTokenProvider);

  final isTokenValid =
      authToken.hasValue &&
      authToken.value != null &&
      authToken.value != AuthToken.empty() &&
      !JwtDecoder.isExpired(authToken.value!.accessToken);

  if (isTokenValid) {
    return await f();
  }

  final tokenNotifier = ref.read(authTokenProvider.notifier);

  return Future(() async {
    try {
      // Ensure only one refresh happens at a time
      final hasRefreshed = await _refreshLock.refresh(() async {
        return await tokenNotifier.refreshAccessToken();
      });

      if (hasRefreshed) {
        return await f();
      } else {
        throw AppException(
          ErrorType.tokenRefreshFailed,
          "Refresh returned false",
        );
      }
    } catch (e, s) {
      tokenNotifier.signOut();
      Error.throwWithStackTrace(e, s);
    }
  });
}

class _TokenRefreshLock {
  Completer<void>? _refreshCompleter;

  bool get isRefreshing => _refreshCompleter != null;

  /// This method ensures that the provided callback is executed only once at a time.
  /// If a refresh is already in progress, it waits for the existing refresh to complete.
  Future<bool> refresh(Future<bool> Function() callback) async {
    if (_refreshCompleter != null) {
      // Already refreshing, just wait for it
      await _refreshCompleter!.future;
      return true;
    }

    _refreshCompleter = Completer();

    try {
      final result = await callback();
      _refreshCompleter?.complete();
      return result;
    } catch (e, s) {
      _refreshCompleter?.completeError(e, s);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }
}

final _refreshLock = _TokenRefreshLock();
