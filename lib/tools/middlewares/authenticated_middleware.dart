// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/router.dart';
import 'package:myecl/settings/providers/module_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:myecl/version/providers/minimal_hyperion_version_provider.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthenticatedMiddleware extends QMiddleware {
  final Ref ref;

  AuthenticatedMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final minimalHyperionVersion = ref.watch(minimalHyperionVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final modules = ref.read(modulesProvider);
    final check = versionVerifier.whenData(
      (value) => value.minimalTitanVersion <= titanVersion,
    );
    if (!pathForwardingNotifier.state.isLoggedIn &&
        path != LoginRouter.root &&
        path != "/") {
      pathForwardingNotifier.forward(path);
    }
    final isHyperionVersionCompatible = versionVerifier.whenData(
      (value) => isVersionCompatible(
        value.version,
        minimalHyperionVersion,
      ),
    );
    return check.when(
      data: (value) {
        if (!value) {
          return AppRouter.update;
        }
        return isHyperionVersionCompatible.when(
          data: (value) {
            if (!value) {
              return AppRouter.rollback;
            }
            if (path == LoginRouter.root &&
                !pathForwardingNotifier.state.isLoggedIn &&
                !isLoggedIn) {
              return null;
            }
            if (!isLoggedIn) {
              return LoginRouter.root;
            }
            if (!pathForwardingNotifier.state.isLoggedIn) {
              pathForwardingNotifier.login();
            }
            if (pathForwardingNotifier.state.path == "/") {
              if (modules.isEmpty) {
                return AppRouter.noModule;
              }
              pathForwardingNotifier.forward(modules.first.root);
              return modules.first.root;
            }
            if (pathForwardingNotifier.state.path != path) {
              return pathForwardingNotifier.state.path;
            }
            return null;
          },
          loading: () => AppRouter.loading,
          error: (error, stack) => AppRouter.noInternet,
        );
      },
      loading: () => AppRouter.loading,
      error: (error, stack) => AppRouter.noInternet,
    );
  }
}
