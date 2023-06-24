import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthenticatedMiddleware extends QMiddleware {
  final ProviderRef ref;

  AuthenticatedMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final pathForwarding = ref.read(pathForwardingProvider);
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier
        .whenData((value) => value.minimalTitanVersion <= titanVersion);
    if (!pathForwarding.isForwarding) {
      pathForwardingNotifier.forward(path);
    }

    return check.when(
        data: (value) {
          if (!value) {
            return AppRouter.update;
          }
          if (pathForwarding.path.startsWith(LoginRouter.root)) {
            pathForwardingNotifier.reset();
            return null;
          }
          if (!isLoggedIn) {
            pathForwardingNotifier.forward(LoginRouter.root);
            return LoginRouter.root;
          }
          if (pathForwarding.path == path) {
            pathForwardingNotifier.reset();
            return null;
          }
          return pathForwarding.path;
        },
        loading: () => AppRouter.loading,
        error: (error, stack) => AppRouter.noInternet);
  }
}
