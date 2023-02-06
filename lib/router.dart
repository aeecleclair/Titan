import 'package:fluro/fluro.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/landing_page.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:myecl/others/ui/no_internert_page.dart';
import 'package:myecl/others/ui/update_page.dart';

class AppRouter {

  static final router = FluroRouter();

  static final _appDrawerHandler = Handler(
    handlerFunc: (context, params) {
      return const AppDrawer();
    },
  );

  static final Handler _authScreenHandler = Handler(
    handlerFunc: (context, params) {
      return const AuthScreen();
    },
  );

  static final Handler _noInternetPageHandler = Handler(
    handlerFunc: (context, params) {
      return const NoInternetPage();
    },
  );

  static final Handler _updatePageHandler = Handler(
    handlerFunc: (context, params) {
      return const UpdatePage();
    },
  );

  static final Handler _landingPageHandler = Handler(
    handlerFunc: (context, params) {
      return const LandingPage();
    },
  );

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = _noInternetPageHandler;
    router.define(
      "/",
      handler: _landingPageHandler,
    );
    router.define(
      "/appDrawer",
      handler: _appDrawerHandler,
    );
    router.define(
      "/authScreen",
      handler: _authScreenHandler,
    );
    router.define(
      "/noInternetPage",
      handler: _noInternetPageHandler,
    );
    router.define(
      "/updatePage",
      handler: _updatePageHandler,
    );
  }
}