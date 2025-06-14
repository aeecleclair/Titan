import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';

/// A wrapper for handling token expiration errors in asynchronous functions.
/// It attempts to refresh the token and re-execute the function if the token has expired.
/// This variation is designed for async functions that return a value.
Future<T> tokenExpireWrapper<T>(Ref ref, Future<T> Function() f) async {
  try {
    return await f();
  } catch (error, stackTrace) {
    return _tokenExpireInternal(ref, f, error, stackTrace);
  }
}

/// A wrapper for handling token expiration errors in asynchronous functions.
/// It attempts to refresh the token and re-execute the function if the token has expired.
/// This variation is designed for async functions that do not return a value.
void tokenExpireWrapperAuth(Ref ref, Future<dynamic> Function() f) async {
  try {
    await f();
  } catch (error, stackTrace) {
    await _tokenExpireInternal(ref, f, error, stackTrace);
  }
}

Future<T> _tokenExpireInternal<T>(
  Ref ref,
  Future<T> Function() f,
  dynamic error,
  dynamic stackTrace,
) async {
  final tokenNotifier = ref.read(authTokenProvider.notifier);
  final isTokenRefreshed = ref.watch(fetchRefreshTokenProvider);
  final refreshTokenFuture = ref.watch(fetchRefreshTokenProvider.future);

  final isLoggedIn = ref.watch(isLoggedInProvider);
  if (error is AppException &&
      error.type == ErrorType.tokenExpire &&
      isLoggedIn) {
    if (isTokenRefreshed.isLoading) {
      return throw (AppException(
        ErrorType.tokenRefreshing,
        "Token is refreshing, please wait.",
      ));
    }
    try {
      final hasRefreshed = await refreshTokenFuture;
      if (hasRefreshed) {
        return await f();
      } else {
        tokenNotifier.signOut();
      }
    } catch (e) {
      tokenNotifier.signOut();
    }
  }
  Error.throwWithStackTrace(error, stackTrace);
}
