import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/is_cinema_admin.dart';
import 'package:titan/cinema/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/cinema/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:titan/cinema/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/cinema/ui/pages/session_pages/add_edit_session.dart'
    deferred as add_edit_session_page;
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:titan/tools/middlewares/notification_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaRouter {
  final Ref ref;
  static const String root = '/cinema';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleCinema,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleCinemaDescription,
    root: CinemaRouter.root,
  );
  CinemaRouter(this.ref);

  QRoute route() => QRoute(
    name: "cinema",
    path: CinemaRouter.root,
    builder: () => main_page.CinemaMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      NotificationMiddleWare(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: detail,
        builder: () => detail_page.DetailPage(),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isCinemaAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_page.DetailPage(),
            middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
          ),
          QRoute(
            path: addEdit,
            builder: () => add_edit_session_page.AddEditSessionPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_session_page.loadLibrary),
            ],
          ),
        ],
      ),
    ],
  );
}
