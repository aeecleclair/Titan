import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/event/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:myecl/calendar/ui/calendar.dart' deferred as home_page;
import 'package:myecl/tools/class/module_router.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CalendarRouter extends ModuleRouter {
  static const String root = '/calendar';
  static const String detail = '/detail';
  static final Module module = Module(
    name: "Calendrier",
    icon: const Left(HeroIcons.calendarDays),
    root: CalendarRouter.root,
    selected: false,
  );
  CalendarRouter(super.ref);

  @override
  QRoute route() => QRoute(
        name: "calendar",
        path: CalendarRouter.root,
        builder: () => home_page.CalendarPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(home_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_page.DetailPage(isAdmin: false),
            middleware: [
              DeferredLoadingMiddleware(detail_page.loadLibrary),
            ],
          ),
        ],
      );
}
