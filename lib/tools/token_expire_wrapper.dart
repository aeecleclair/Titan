import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/asking_refresh_token_provider.dart';

Future tokenExpireWrapper(WidgetRef ref, Future<dynamic> Function() f) async {
  await f().catchError((error, stackTrace) async {
    final tokenNotifier = ref.watch(authTokenProvider.notifier);
    final askingRefreshTokenNotifier =
        ref.watch(askingRefreshTokenProvider.notifier);
    final askingRefreshToken = ref.watch(askingRefreshTokenProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    if (error is AppException &&
        error.type == ErrorType.tokenExpire &&
        isLoggedIn) {
      if (askingRefreshToken) return;
      askingRefreshTokenNotifier.setbool(true);
      try {
        final value = await tokenNotifier.refreshToken();
        if (value) {
          f();
        } else {
          tokenNotifier.deleteToken();
        }
      } catch (e) {
        tokenNotifier.deleteToken();
      }
      askingRefreshTokenNotifier.setbool(false);
    }
  });
}

void tokenExpireWrapperAuth(Ref ref, Future<dynamic> Function() f) async {
  f().catchError((error, stackTrace) async {
    final tokenNotifier = ref.watch(authTokenProvider.notifier);
    final askingRefreshTokenNotifier =
        ref.watch(askingRefreshTokenProvider.notifier);
    final askingRefreshToken = ref.watch(askingRefreshTokenProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    if (error is AppException &&
        error.type == ErrorType.tokenExpire &&
        isLoggedIn) {
      if (askingRefreshToken) return;
      askingRefreshTokenNotifier.setbool(true);
      try {
        final value = await tokenNotifier.refreshToken();
        if (value) {
          f();
        } else {
          tokenNotifier.deleteToken();
        }
      } catch (e) {
        tokenNotifier.deleteToken();
      }
      askingRefreshTokenNotifier.setbool(false);
    }
  });
}
