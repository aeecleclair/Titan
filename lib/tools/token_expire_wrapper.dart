import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';

void tokenExpireWrapper(WidgetRef ref, Future<dynamic> Function() f) async {
  f().catchError((error, stackTrace) async {
    if (error is AppException && error.type == ErrorType.tokenExpire) {
      try {
        final value = await ref.read(authTokenProvider.notifier).refreshToken();
        if (value) {
          f();
        } else {
          ref.watch(authTokenProvider.notifier).deleteToken();
        }
      } catch (e) {
        ref.watch(authTokenProvider.notifier).deleteToken();
      }
    }
  });
}

void tokenExpireWrapperAuth(
    StateNotifierProviderRef<OpenIdTokenProvider,
            AsyncValue<Map<String, String>>> ref, Future<dynamic> Function() f) async {
  f().catchError((error, stackTrace) async {
    if (error is AppException && error.type == ErrorType.tokenExpire) {
      try {
        final value = await ref.read(authTokenProvider.notifier).refreshToken();
        if (value) {
          f();
        } else {
          ref.watch(authTokenProvider.notifier).deleteToken();
        }
      } catch (e) {
        ref.watch(authTokenProvider.notifier).deleteToken();
      }
    }
  });
}
