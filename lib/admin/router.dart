import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/admin/ui/pages/users_management_page/users_management_page.dart'
    deferred as users_managmement_page;
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminRouter {
  final Ref ref;
  static const String root = '/admin';
  static const String usersManagement = '/users_management';
  static const String usersGroups = '/users_groups';
  static const String groupNotifications = '/group_notifications';
  static final Module module = Module(
    getName: (context) => "Admin",
    description: "Gérer les paramètres de l'application",
    root: AdminRouter.root,
  );

  AdminRouter(this.ref);

  QRoute route() => QRoute(
    name: "admin",
    path: AdminRouter.root,
    builder: () => main_page.AdminMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: usersManagement,
        builder: () => users_managmement_page.UsersManagementPage(),
        middleware: [
          DeferredLoadingMiddleware(users_managmement_page.loadLibrary),
        ],
      ),
    ],
  );
}
