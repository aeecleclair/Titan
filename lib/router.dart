import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/centralisation/router.dart';
import 'package:titan/cinema/router.dart';
import 'package:titan/event/router.dart';
import 'package:titan/flappybird/router.dart';
import 'package:titan/home/router.dart';
import 'package:titan/home/ui/home.dart' deferred as home_page;
import 'package:titan/loan/router.dart';
import 'package:titan/login/router.dart';
import 'package:titan/others/ui/loading_page.dart' deferred as loading_page;
import 'package:titan/others/ui/no_internet_page.dart'
    deferred as no_internet_page;
import 'package:titan/others/ui/no_module.dart' deferred as no_module_page;
import 'package:titan/others/ui/rollback_page.dart' deferred as rollback_page;
import 'package:titan/others/ui/update_page.dart' deferred as update_page;
import 'package:titan/mypayment/router.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/recommendation/router.dart';
import 'package:titan/seed-library/router.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:titan/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/centralassociation/router.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  final Ref ref;
  late List<QRoute> routes = [];
  static const String root = '/';
  static const String loading = '/loading';
  static const String update = '/update';
  static const String noInternet = '/no_internet';
  static const String noModule = '/no_module';
  static const String rollback = '/rollback';

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
        middleware: [DeferredLoadingMiddleware(loading_page.loadLibrary)],
      ),
      QRoute(
        path: noInternet,
        builder: () => no_internet_page.NoInternetPage(),
        middleware: [DeferredLoadingMiddleware(no_internet_page.loadLibrary)],
      ),
      QRoute(
        path: update,
        builder: () => update_page.UpdatePage(),
        middleware: [DeferredLoadingMiddleware(update_page.loadLibrary)],
      ),
      QRoute(
        path: noModule,
        builder: () => no_module_page.NoModulePage(),
        middleware: [DeferredLoadingMiddleware(no_module_page.loadLibrary)],
      ),
      QRoute(
        path: rollback,
        builder: () => rollback_page.RollbackPage(),
        middleware: [DeferredLoadingMiddleware(rollback_page.loadLibrary)],
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
      LoginRouter(ref).route(),
      PaymentRouter(ref).route(),
      PhonebookRouter(ref).route(),
      PhRouter(ref).route(),
      PurchasesRouter(ref).route(),
      RaffleRouter(ref).route(),
      RecommendationRouter(ref).route(),
      SettingsRouter(ref).route(),
      ShotgunRouter(ref).route(),
      VoteRouter(ref).route(),
      SeedLibraryRouter(ref).route(),
    ];
  }
}
