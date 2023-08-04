import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/cinema/providers/is_cinema_admin.dart';
import 'package:myecl/cinema/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/cinema/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/cinema/ui/pages/main_page/main_page.dart';
import 'package:myecl/cinema/ui/pages/session_pages/add_edit_session.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/notification_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaRouter {
  final ProviderRef ref;
  static const String root = '/cinema';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Cinéma",
      icon: const Left(HeroIcons.ticket),
      root: CinemaRouter.root,
      selected: false);
  CinemaRouter(this.ref);

  QRoute route() => QRoute(
        path: CinemaRouter.root,
        builder: () => const CinemaMainPage(),
        middleware: [AuthenticatedMiddleware(ref), NotificationMiddleWare(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            AdminMiddleware(ref, isCinemaAdminProvider),
          ], children: [
            QRoute(path: detail, builder: () => const DetailPage()),
            QRoute(path: addEdit, builder: () => const AddEditSessionPage()),
          ]),
        ],
      );
}
