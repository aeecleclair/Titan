import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/authenticator/authenticator.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/interceptors/auth_interceptor.dart';
import 'package:titan/tools/interceptors/log_interceptor.dart';

final repositoryProvider = Provider((ref) {
  final authenticator = ref.watch(authenticatorProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);
  final logInterceptor = ref.watch(logInterceptorProvider);
  return Openapi.create(
    baseUrl: Uri.parse(getTitanHost()),
    authenticator: authenticator,
    interceptors: [authInterceptor, logInterceptor],
  );
});
