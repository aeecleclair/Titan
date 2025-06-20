import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myecl/auth/class/auth_token.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';

/// A wrapper for handling token expiration in asynchronous functions.
/// This function checks if the token is valid before executing the provided function.
/// If the token is expired, it attempts to refresh the token and then re-execute the
/// provided function. (A lock is used to ensure that only one refresh happens at a time.)
/// If the refresh fails, it signs out the user and throws an exception.
Future<T> tokenExpireWrapper<T>(Ref ref, Future<T> Function() f) async {
  final isTokenValid = ref.read(
    authTokenProvider.select(
      (authToken) =>
          authToken.hasValue &&
          authToken.value != null &&
          authToken.value != AuthToken.empty() &&
          !JwtDecoder.isExpired(authToken.value!.accessToken),
    ),
  );

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
        throw AppException(ErrorType.tokenRefreshFailed, "Refresh failed");
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
