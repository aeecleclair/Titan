import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';
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
    name: "Évenements",
    icon: const Left(HeroIcons.calendar),
    root: EventRouter.root,
    selected: false,
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
