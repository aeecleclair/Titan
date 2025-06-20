import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/routing/providers/auth_redirect_service_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthenticatedMiddleware extends QMiddleware {
  final Ref ref;

  AuthenticatedMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final redirectPath = ref.read(
      authRedirectServiceProvider.select(
        (service) => service.getRedirect(path),
      ),
    );
    return redirectPath;
  }
}
