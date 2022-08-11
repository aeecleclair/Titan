import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';

void tokenExpireWrapper(WidgetRef ref, Function f) {
  try {
    f();
  } catch (e) {
    if (e is AppException) {
      switch (e.type) {
        case ErrorType.tokenExpire:
          ref.read(authTokenProvider.notifier).refreshToken().then((value) {
            if (value) {
              f();
            }
          });
          break;
        case ErrorType.notFound:
          break;
        case ErrorType.invalidData:
          break;
      }
    }
  }
}
