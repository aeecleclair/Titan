import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/home/ui/home.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/others/ui/loading_page.dart';
import 'package:myecl/others/ui/no_internet_page.dart';
import 'package:myecl/others/ui/update_page.dart';
import 'package:myecl/settings/router.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  final ProviderRef ref;
  late List<QRoute> routes = [];
  static const String root = '/';
  static const String loading = '/loading';
  static const String update = '/update';
  static const String noInternet = '/no_internet';
  AppRouter(this.ref) {
    routes = [
      QRoute(
        path: root,
        builder: () => const HomePage(),
        middleware: [AuthenticatedMiddleware(ref)],
      ),
      QRoute(
        path: loading,
        builder: () => const LoadingPage(),
      ),
      QRoute(
        path: noInternet,
        builder: () => const Scaffold(body: NoInternetPage()),
      ),
      QRoute(
        path: update,
        builder: () => const Scaffold(body: UpdatePage()),
      ),
      AdminRouter(ref).route(),
      AdvertRouter(ref).route(),
      AmapRouter(ref).route(),
      BookingRouter(ref).route(),
      CentralisationRouter(ref).route(),
      CinemaRouter(ref).route(),
      EventRouter(ref).route(),
      HomeRouter(ref).route(),
      LoanRouter(ref).route(),
      LoginRouter(ref).accountRoute(),
      LoginRouter(ref).route(),
      LoginRouter(ref).passwordRoute(),
      RaffleRouter(ref).route(),
      SettingsRouter(ref).route(),
      VoteRouter(ref).route(),
    ];
  }
}
