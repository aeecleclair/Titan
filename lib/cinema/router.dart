import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/middlewares/cinema_admin_middleware.dart';
import 'package:myecl/cinema/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/cinema/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/cinema/ui/pages/main_page/main_page.dart';
import 'package:myecl/cinema/ui/pages/session_pages/add_edit_session.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaRouter {
  final ProviderRef ref;
  static const String root = '/cinema';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  CinemaRouter(this.ref);

  QRoute route() => QRoute(
        path: CinemaRouter.root,
        builder: () => const CinemaMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            CinemaAdminMiddleware(ref),
          ], children: [
            QRoute(path: detail, builder: () => const DetailPage()),
            QRoute(path: addEdit, builder: () => const AddEditSessionPage()),
          ]),
        ],
      );
}
