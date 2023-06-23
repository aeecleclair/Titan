import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/middlewares/event_admin_middleware.dart';
import 'package:myecl/event/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/event/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/event/ui/pages/event_pages/add_edit_event_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventRouter {
  final ProviderRef ref;
  static const String root = '/event';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  late List<QRoute> routes = [];
  EventRouter(this.ref) {
    routes = [
      QRoute(path: admin, builder: () => const AdminPage(), middleware: [
        EventAdminMiddleware(ref),
      ], children: [
        QRoute(path: detail, builder: () => const DetailPage(isAdmin: true)),
        QRoute(
            path: addEdit,
            builder: () => const AddEditEventPage()),
      ]),
      QRoute(
          path: addEdit, builder: () => const AddEditEventPage()),
      QRoute(path: detail, builder: () => const DetailPage(isAdmin: false)),
    ];
  }
}
