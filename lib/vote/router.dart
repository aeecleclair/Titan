import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/vote/middlewares/vote_admin_middleware.dart';
import 'package:myecl/vote/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/vote/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/vote/ui/pages/main_page/main_page.dart';
import 'package:myecl/vote/ui/pages/pretendance_pages/add_edit_pretendance.dart';
import 'package:myecl/vote/ui/pages/section_pages/add_section.dart';
import 'package:qlevar_router/qlevar_router.dart';

class VoteRouter {
  final ProviderRef ref;
  static const String root = '/vote';
  static const String admin = '/admin';
  static const String addEditPretendance = '/add_edit_pretendance';
  static const String addSection = '/add_edit_section';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Vote",
      icon: HeroIcons.envelopeOpen,
      root: VoteRouter.root,
      selected: false);
  VoteRouter(this.ref);

  QRoute route() => QRoute(
        path: VoteRouter.root,
        builder: () => const VoteMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            VoteAdminMiddleware(ref),
          ], children: [
            QRoute(path: detail, builder: () => const DetailPage()),
            QRoute(
                path: addEditPretendance,
                builder: () => const AddEditPretendancePage()),
            QRoute(path: addSection, builder: () => const AddSectionPage()),
          ]),
          QRoute(path: detail, builder: () => const DetailPage()),
        ],
      );
}
