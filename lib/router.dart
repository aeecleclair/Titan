import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/router.dart';
import 'package:myemapp/advert/router.dart';
import 'package:myemapp/event/router.dart';
import 'package:myemapp/home/router.dart';
import 'package:myemapp/home/ui/home.dart' deferred as home_page;
import 'package:myemapp/login/router.dart';
import 'package:myemapp/others/ui/loading_page.dart' deferred as loading_page;
import 'package:myemapp/others/ui/no_internet_page.dart'
    deferred as no_internet_page;
import 'package:myemapp/others/ui/no_module.dart' deferred as no_module_page;
import 'package:myemapp/others/ui/update_page.dart' deferred as update_page;
import 'package:myemapp/paiement/router.dart';
import 'package:myemapp/phonebook/router.dart';
import 'package:myemapp/settings/router.dart';
import 'package:myemapp/tools/middlewares/authenticated_middleware.dart';
import 'package:myemapp/tools/middlewares/deferred_middleware.dart';
import 'package:myemapp/vote/router.dart';
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
      AdminRouter(ref).route(),
      AdvertRouter(ref).route(),
      EventRouter(ref).route(),
      HomeRouter(ref).route(),
      LoginRouter(ref).accountRoute(),
      LoginRouter(ref).route(),
      LoginRouter(ref).passwordRoute(),
      PaymentRouter(ref).route(),
      PhonebookRouter(ref).route(),
      SettingsRouter(ref).route(),
      VoteRouter(ref).route(),
    ];
  }
}
