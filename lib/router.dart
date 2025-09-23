import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/flappybird/router.dart';
import 'package:myecl/centralassos/router.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/home/ui/home.dart' deferred as home_page;
import 'package:myecl/loan/router.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/others/ui/loading_page.dart' deferred as loading_page;
import 'package:myecl/others/ui/no_internet_page.dart'
    deferred as no_internet_page;
import 'package:myecl/others/ui/no_module.dart' deferred as no_module_page;
import 'package:myecl/others/ui/update_page.dart' deferred as update_page;
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/recommendation/router.dart';
import 'package:myecl/settings/router.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:myecl/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  final Ref ref;
  late List<QRoute> routes = [];
  static const String root = '/';
  static const String loading = '/loading';
  static const String update = '/update';
  static const String noInternet = '/no_internet';
  static const String noModule = '/no_module';

  AppRouter(this.ref) {
    routes = [
      QRoute(
        path: root,
        builder: () => home_page.HomePage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(home_page.loadLibrary),
        ],
      ),
      QRoute(
        path: loading,
        builder: () => loading_page.LoadingPage(),
        middleware: [
          DeferredLoadingMiddleware(loading_page.loadLibrary),
        ],
      ),
      QRoute(
        path: noInternet,
        builder: () => no_internet_page.NoInternetPage(),
        middleware: [
          DeferredLoadingMiddleware(no_internet_page.loadLibrary),
        ],
      ),
      QRoute(
        path: update,
        builder: () => update_page.UpdatePage(),
        middleware: [
          DeferredLoadingMiddleware(update_page.loadLibrary),
        ],
      ),
      QRoute(
        path: noModule,
        builder: () => no_module_page.NoModulePage(),
        middleware: [
          DeferredLoadingMiddleware(no_module_page.loadLibrary),
        ],
      ),
      AdminRouter(ref).route(),
      AdvertRouter(ref).route(),
      AmapRouter(ref).route(),
      BookingRouter(ref).route(),
      CentralisationRouter(ref).route(),
      CentralassociationRouter(ref).route(),
      CinemaRouter(ref).route(),
      EventRouter(ref).route(),
      FlappyBirdRouter(ref).route(),
      HomeRouter(ref).route(),
      LoanRouter(ref).route(),
      LoginRouter(ref).accountRoute(),
      LoginRouter(ref).route(),
      LoginRouter(ref).passwordRoute(),
      RaffleRouter(ref).route(),
      RecommendationRouter(ref).route(),
      SettingsRouter(ref).route(),
      VoteRouter(ref).route(),
      PhonebookRouter(ref).route(),
      PhRouter(ref).route(),
      PurchasesRouter(ref).route(),
    ];
  }
}
