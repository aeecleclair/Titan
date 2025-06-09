import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';

/// A wrapper for handling token expiration errors in asynchronous functions.
/// It attempts to refresh the token and re-execute the function if the token has expired.
/// This variation is designed for async functions that return a value.
Future<T?> tokenExpireWrapper<T>(WidgetRef ref, Future<T> Function() f) async {
  try {
    return await f();
  } catch (error, stackTrace) {
    return _tokenExpireInternal(ref as Ref, f, error, stackTrace);
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

Future<T?> _tokenExpireInternal<T>(
  Ref ref,
  Future<T> Function() f,
  dynamic error,
  dynamic stackTrace,
) async {
  final tokenNotifier = ref.watch(authTokenProvider.notifier);
  final refreshedToken = ref.watch(refreshTokenProvider);
  final refreshTokenFuture = ref.watch(refreshTokenProvider.future);

  final isLoggedIn = ref.watch(isLoggedInProvider);
  if (error is AppException &&
      error.type == ErrorType.tokenExpire &&
      isLoggedIn) {
    if (refreshedToken.isLoading) return null;
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
  } else {
    // Re-throw if it's not a token expiration error
    Error.throwWithStackTrace(error, stackTrace);
  }
  return null;
}
