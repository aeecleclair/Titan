import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/shotgun/ui/pages/main_page/main_page.dart';
import 'package:titan/shotgun/ui/pages/admin/admin_page.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ShotgunRouter {
  final Ref ref;
  static const String root = '/shotgun';
  static const String admin = '/admin';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    name: "Shotgun",
    icon: const Left(HeroIcons.bolt),
    root: ShotgunRouter.root,
    selected: false,
  );
  ShotgunRouter(this.ref);

  QRoute route() => QRoute(
    name: "shotgun",
    path: ShotgunRouter.root,
    builder: () => const ShotgunMainPage(),
    middleware: [AuthenticatedMiddleware(ref)],
    children: [
      QRoute(
        path: admin,
        builder: () => const AdminPage(),
        middleware: [AdminMiddleware(ref, isAdminProvider)],
        // children: [
        //   QRoute(
        //     path: editAssociation,
        //     builder: () => AssociationEditorPage(),
        //     children: [
        //       QRoute(
        //         path: addEditMember,
        //         builder: () => const MembershipEditorPage(),
        //       ),
        //     ],
        //   ),
        //   QRoute(
        //     path: createAssociaiton,
        //     builder: () => AssociationCreationPage(),
        //   ),
        // ],
      ),
      // QRoute(
      //   path: addEditMember,
      //   builder: () => const ManagementGreenhousePage(),
      //   middleware: [AdminMiddleware(ref, isGreenHouseAdminProvider)],
      // ),
      // QRoute(
      //   path: associationDetail,
      //   builder: () => const AssociationPage(),
      //   children: [
      //     QRoute(
      //       path: editAssociation,
      //       builder: () => AssociationEditorPage(),
      //       middleware: [
      //         AdminMiddleware(ref, isAssociationPresidentProvider),
      //       ],
      //       children: [
      //         QRoute(
      //           path: addEditMember,
      //           builder: () => const MembershipEditorPage(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      // QRoute(path: memberDetail, builder: () => const MemberDetailPage()),
    ],
  );
}
