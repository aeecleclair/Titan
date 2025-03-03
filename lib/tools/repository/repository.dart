import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/authenticator/authenticator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/interceptors/auth_interceptor.dart';
import 'package:myecl/tools/interceptors/log_interceptor.dart';

final repositoryProvider = Provider((ref) {
  final authenticator = ref.watch(authenticatorProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);
  final logInterceptor = ref.watch(logInterceptorProvider);
  return Openapi.create(
    baseUrl: Uri.parse(getTitanHost()),
    authenticator: authenticator,
    interceptors: [
      authInterceptor,
      logInterceptor,
    ],
  );
});
