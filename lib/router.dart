import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/middlewares/admin_middleware.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/pages/main_page/main_page.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/ui/pages/main_page/main_page.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/home/ui/home.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/ui/pages/main_page/main_page.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:myecl/others/ui/loading_page.dart';
import 'package:myecl/others/ui/no_internert_page.dart';
import 'package:myecl/settings/router.dart';
import 'package:myecl/settings/ui/pages/main_page/main_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  final ProviderRef ref;
  late List<QRoute> routes = [];
  static const String root = '/';
  static const String login = '/login';
  static const String loading = '/loading';
  static const String noInternet = '/no_internet';
  AppRouter(this.ref) {
    routes = [
      QRoute(
        path: root,
        builder: () => const AppDrawer(),
        middleware: [AuthenticatedMiddleware(ref)],
      ),
      QRoute(
          path: SettingsRouter.root,
          builder: () => const SettingsMainPage(),
          middleware: [AuthenticatedMiddleware(ref)],
          children: SettingsRouter().routes),
      QRoute(
        path: AdminRouter.root,
        builder: () => const AdminMainPage(),
        middleware: [AuthenticatedMiddleware(ref), AdminMiddleware(ref)],
        children: AdminRouter().routes,
      ),
      QRoute(
        path: BookingRouter.root,
        builder: () => const BookingMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: BookingRouter(ref).routes,
      ),
      QRoute(
        path: EventRouter.root,
        builder: () => const EventMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: EventRouter(ref).routes,
      ),
      QRoute(
        path: LoanRouter.root,
        builder: () => const LoanMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: LoanRouter(ref).routes,
      ),
      QRoute(
        path: HomeRouter.root,
        builder: () => const HomePage(),
        middleware: [AuthenticatedMiddleware(ref)],
      ),
      QRoute(
        path: login,
        builder: () => const AuthScreen(),
      ),
      QRoute(
        path: loading,
        builder: () => const LoadingPage(),
      ),
      QRoute(
        path: noInternet,
        builder: () => const Scaffold(body: NoInternetPage()),
      ),
    ];
  }
}
