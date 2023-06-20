import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:myecl/others/ui/loading_page.dart';
import 'package:myecl/others/ui/no_internert_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  ref.watch(versionVerifierProvider);
  ref.watch(titanVersionProvider);
  ref.watch(isLoggedInProvider);
  return AppRouter(ref);
});

class AppRouter {
  final ProviderRef ref;
  late List<QRoute> routes = [];
  static String home = '/';
  static String login = '/login';
  static String loading = '/loading';
  static String noInternet = '/no_internet';
  AppRouter(this.ref) {
    routes = [
      QRoute(
          path: home,
          builder: () => const AppDrawer(),
          middleware: [AuthenticatedMiddleware(ref)]),
      QRoute(path: login, builder: () => const AuthScreen()),
      QRoute(
          path: loading,
          builder: () => const LoadingPage()),
      QRoute(
          path: noInternet,
          builder: () => const Scaffold(body: NoInternetPage())),
    ];
  }
}
