import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/admin/ui/pages/add_association_page/add_association_page.dart'
    deferred as add_association_page;
import 'package:myecl/admin/ui/pages/add_loaner_page/add_loaner_page.dart'
    deferred as add_loaner_page;
import 'package:myecl/admin/ui/pages/edit_module_visibility/edit_module_visibility.dart'
    deferred as edit_module_visibility;
import 'package:myecl/admin/ui/pages/edit_page/edit_page.dart'
    deferred as edit_page;
import 'package:myecl/admin/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
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
        name: "admin",
        path: AdminRouter.root,
        builder: () => main_page.AdminMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: addAssociation,
            builder: () => add_association_page.AddAssociationPage(),
            middleware: [
              DeferredLoadingMiddleware(add_association_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addLoaner,
            builder: () => add_loaner_page.AddLoanerPage(),
            middleware: [
              DeferredLoadingMiddleware(add_loaner_page.loadLibrary),
            ],
          ),
          QRoute(
            path: editAssociation,
            builder: () => edit_page.EditAssociationPage(),
            middleware: [DeferredLoadingMiddleware(edit_page.loadLibrary)],
          ),
          QRoute(
            path: editModuleVisibility,
            builder: () => edit_module_visibility.EditModulesVisibilityPage(),
            middleware: [
              DeferredLoadingMiddleware(edit_module_visibility.loadLibrary),
            ],
          ),
        ],
      );
}
