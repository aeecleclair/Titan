import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';

void tokenExpireWrapper(WidgetRef ref, Future<dynamic> Function() f) async {
  f().catchError((error, stackTrace) {
    if (error is AppException && error.type == ErrorType.tokenExpire) {
      ref.read(authTokenProvider.notifier).refreshToken().then((value) async {
        if (value) {
          f();
        }
      });
    }
  });
}
