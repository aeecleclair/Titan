import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/asking_refresh_token_provider.dart';

Future tokenExpireWrapper(WidgetRef ref, Future<dynamic> Function() f) async {
  await f().catchError((error, stackTrace) async {
    final tokenNotifier = ref.watch(authTokenProvider.notifier);
    final askingRefreshTokenNotifier = ref.watch(
      askingRefreshTokenProvider.notifier,
    );
    final askingRefreshToken = ref.watch(askingRefreshTokenProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    if (error is AppException &&
        error.type == ErrorType.tokenExpire &&
        isLoggedIn) {
      if (askingRefreshToken) return;
      askingRefreshTokenNotifier.setAskingRefresh(true);
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
      askingRefreshTokenNotifier.setAskingRefresh(false);
    }
  });
}

void tokenExpireWrapperAuth(Ref ref, Future<dynamic> Function() f) async {
  f().catchError((error, stackTrace) async {
    final tokenNotifier = ref.watch(authTokenProvider.notifier);
    final askingRefreshTokenNotifier = ref.watch(
      askingRefreshTokenProvider.notifier,
    );
    final askingRefreshToken = ref.watch(askingRefreshTokenProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    if (error is AppException &&
        error.type == ErrorType.tokenExpire &&
        isLoggedIn) {
      if (askingRefreshToken) return;
      askingRefreshTokenNotifier.setAskingRefresh(true);
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
      askingRefreshTokenNotifier.setAskingRefresh(false);
    }
  });
}
