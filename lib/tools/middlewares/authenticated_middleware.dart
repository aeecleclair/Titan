// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/login/router.dart';
import 'package:titan/router.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/version/providers/titan_version_provider.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthenticatedMiddleware extends QMiddleware {
  final Ref ref;

  AuthenticatedMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier.whenData(
      (value) => value.minimalTitanVersion <= titanVersion,
    );
    if (!pathForwardingNotifier.state.isLoggedIn &&
        path != LoginRouter.root &&
        path != "/") {
      pathForwardingNotifier.forward(path);
    }
    return check.when(
      data: (value) {
        if (!value) {
          return AppRouter.update;
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
          pathForwardingNotifier.forward(FeedRouter.root);
          return FeedRouter.root;
        }
        if (pathForwardingNotifier.state.path != path) {
          return pathForwardingNotifier.state.path;
        }
        return null;
      },
      loading: () => AppRouter.loading,
      error: (error, stack) => AppRouter.noInternet,
    );
  }
}
