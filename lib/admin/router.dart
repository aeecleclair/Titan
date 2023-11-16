import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/admin/ui/pages/add_association_page/add_association_page.dart';
import 'package:myecl/admin/ui/pages/add_loaner_page/add_loaner_page.dart';
import 'package:myecl/admin/ui/pages/edit_module_visibility/edit_module_visibility.dart';
import 'package:myecl/admin/ui/pages/edit_page/edit_page.dart';
import 'package:myecl/admin/ui/pages/main_page/main_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminRouter {
  final ProviderRef ref;
  static const String root = '/admin';
  static const String addAssociation = '/add_association';
  static const String addLoaner = '/add_loaner';
  static const String editAssociation = '/edit_association';
  static const String editModuleVisibility = '/edit_module_visibility';
  AdminRouter(this.ref);

  QRoute route() => QRoute(
          path: AdminRouter.root,
          builder: () => const AdminMainPage(),
          middleware: [
            AuthenticatedMiddleware(ref),
            AdminMiddleware(ref, isAdminProvider)
          ],
          children: [
            QRoute(
                path: addAssociation,
                builder: () => const AddAssociationPage()),
            QRoute(path: addLoaner, builder: () => const AddLoanerPage()),
            QRoute(
                path: editAssociation,
                builder: () => const EditAssociationPage()),
            QRoute(
                path: editModuleVisibility,
                builder: () => const EditModulesVisibilityPage()),
          ]);
}
