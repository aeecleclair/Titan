import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/event/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:titan/home/ui/home.dart' deferred as home_page;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HomeRouter {
  final Ref ref;
  static const String root = '/home';
  static const String detail = '/detail';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleCalendar,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleCalendarDescription,
    root: HomeRouter.root,
  );
  HomeRouter(this.ref);

  QRoute route() => QRoute(
    name: "home",
    path: HomeRouter.root,
    builder: () => home_page.HomePage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(home_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: detail,
        builder: () => detail_page.DetailPage(isAdmin: false),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
    ],
  );
}
