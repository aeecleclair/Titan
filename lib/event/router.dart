import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:myecl/event/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/event/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/event/ui/pages/event_pages/add_edit_event_page.dart';
import 'package:myecl/event/ui/pages/main_page/main_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventRouter {
  final ProviderRef ref;
  static const String root = '/event';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Évenements",
      icon: const Left(HeroIcons.calendar),
      root: EventRouter.root,
      selected: false);
  EventRouter(this.ref);

  QRoute route() => QRoute(
        path: EventRouter.root,
        builder: () => const EventMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            AdminMiddleware(ref, isEventAdminProvider),
          ], children: [
            QRoute(
                path: detail, builder: () => const DetailPage(isAdmin: true)),
            QRoute(path: addEdit, builder: () => const AddEditEventPage()),
          ]),
          QRoute(path: addEdit, builder: () => const AddEditEventPage()),
          QRoute(path: detail, builder: () => const DetailPage(isAdmin: false)),
        ],
      );
}
