import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/greenhouse/providers/is_greenhouse_admin_provider.dart';
import 'package:myecl/greenhouse/ui/pages/admin_page/admin_greenhouse_page.dart';
import 'package:myecl/greenhouse/ui/pages/admin_page/admin_page.dart';
// import 'package:myecl/greenhouse/ui/pages/association_creation_page/association_creation_page.dart';
// import 'package:myecl/greenhouse/ui/pages/association_editor_page/association_editor_page.dart';
// import 'package:myecl/greenhouse/ui/pages/association_page/association_page.dart';
import 'package:myecl/greenhouse/ui/pages/main_page/main_page.dart';
// import 'package:myecl/greenhouse/ui/pages/member_detail_page/member_detail_page.dart';
// import 'package:myecl/greenhouse/ui/pages/membership_editor_page/membership_editor_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class GreenHouseRouter {
  final Ref ref;
  static const String root = '/greenhouse';
  static const String admin = '/admin';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    name: "GreenHouse",
    icon: const Left(HeroIcons.globeEuropeAfrica),
    root: GreenHouseRouter.root,
    selected: false,
  );
  GreenHouseRouter(this.ref);

  QRoute route() => QRoute(
        name: "greenhouse",
        path: GreenHouseRouter.root,
        builder: () => const GreenHouseMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(
            path: admin,
            builder: () => const AdminPage(),
            middleware: [
              AdminMiddleware(ref, isAdminProvider),
            ],
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
          QRoute(
            path: addEditMember,
            builder: () => const ManagementGreenhousePage(),
            middleware: [
              AdminMiddleware(ref, isGreenHouseAdminProvider),
            ],
          ),
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
