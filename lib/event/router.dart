import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/event/providers/is_admin_provider.dart';
import 'package:titan/event/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:titan/event/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/event/ui/pages/event_pages/add_edit_event_page.dart'
    deferred as add_edit_event_page;
import 'package:titan/event/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventRouter {
  final Ref ref;
  static const String root = '/event';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleEvent,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleEventDescription,
    root: EventRouter.root,
  );
  EventRouter(this.ref);

  QRoute route() => QRoute(
    name: "event",
    path: EventRouter.root,
    builder: () => main_page.EventMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isEventAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_page.DetailPage(isAdmin: true),
            middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
          ),
          QRoute(
            path: addEdit,
            builder: () => add_edit_event_page.AddEditEventPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_event_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: addEdit,
        builder: () => add_edit_event_page.AddEditEventPage(),
        middleware: [
          DeferredLoadingMiddleware(add_edit_event_page.loadLibrary),
        ],
      ),
      QRoute(
        path: detail,
        builder: () => detail_page.DetailPage(isAdmin: false),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
    ],
  );
}
