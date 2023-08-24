import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/admin/ui/pages/add_asso_page/add_asso_page.dart';
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
  static const String addAsso = '/add_asso';
  static const String addLoaner = '/add_loaner';
  static const String editAsso = '/edit_asso';
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
            QRoute(path: addAsso, builder: () => const AddAssoPage()),
            QRoute(path: addLoaner, builder: () => const AddLoanerPage()),
            QRoute(path: editAsso, builder: () => const EditAssoPage()),
            QRoute(
                path: editModuleVisibility,
                builder: () => const EditModulesVisibilityPage()),
          ]);
}
