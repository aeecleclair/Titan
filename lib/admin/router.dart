import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/ui/pages/groups/edit_group_page/edit_group_page.dart'
    deferred as edit_group_page;
import 'package:titan/admin/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/admin/ui/pages/groups/groups_page/groups_page.dart'
    deferred as groups_page;
import 'package:titan/admin/ui/pages/users_management_page/users_management_page.dart'
    deferred as users_managmement_page;
import 'package:titan/admin/ui/pages/group_notifification_page/group_notification_page.dart'
    deferred as group_notification_page;
import 'package:titan/admin/ui/pages/structure_page/add_edit_structure_page/add_edit_structure_page.dart'
    deferred as add_edit_structure_page;
import 'package:titan/navigation/class/module.dart';
import 'package:titan/admin/ui/pages/structure_page/structure_page.dart'
    deferred as structure_page;
import 'package:titan/admin/ui/pages/membership/association_membership_page/association_membership_page.dart'
    deferred as association_membership_page;
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/association_membership_detail_page.dart'
    deferred as association_membership_detail_page;
import 'package:titan/admin/ui/pages/membership/add_edit_user_membership_page/add_edit_user_membership_page.dart'
    deferred as add_edit_user_membership_page;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminRouter {
  final Ref ref;
  static const String structures = '/structures';
  static const String addEditStructure = '/add_edit_structure';
  static const String root = '/admin';
  static const String usersManagement = '/users_management';
  static const String usersGroups = '/users_groups';
  static const String groupNotification = '/group_notification';
  static const String addGroup = '/add_group';
  static const String editGroup = '/edit_group';
  static const String associationMemberships = '/association_memberships';
  static const String detailAssociationMembership =
      '/detail_association_membership';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    getName: (context) => "Admin",
    description: "Gérer les utilisateurs de l'application",
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
      QRoute(
        path: usersGroups,
        builder: () => groups_page.GroupsPage(),
        middleware: [DeferredLoadingMiddleware(groups_page.loadLibrary)],
        children: [
          QRoute(
            path: editGroup,
            builder: () => edit_group_page.EditGroupPage(),
            middleware: [
              DeferredLoadingMiddleware(edit_group_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: groupNotification,
        builder: () => group_notification_page.GroupNotificationPage(),
        middleware: [
          DeferredLoadingMiddleware(group_notification_page.loadLibrary),
        ],
      ),
      QRoute(
        path: structures,
        builder: () => structure_page.StructurePage(),
        middleware: [DeferredLoadingMiddleware(structure_page.loadLibrary)],
        children: [
          QRoute(
            path: addEditStructure,
            builder: () => add_edit_structure_page.AddEditStructurePage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_structure_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: associationMemberships,
        builder: () => association_membership_page.AssociationMembershipsPage(),
        middleware: [
          DeferredLoadingMiddleware(association_membership_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detailAssociationMembership,
            builder: () =>
                association_membership_detail_page.AssociationMembershipEditorPage(),
            middleware: [
              DeferredLoadingMiddleware(
                association_membership_detail_page.loadLibrary,
              ),
            ],
            children: [
              QRoute(
                path: addEditMember,
                builder: () =>
                    add_edit_user_membership_page.AddEditUserMembershipPage(),
                middleware: [
                  DeferredLoadingMiddleware(
                    add_edit_user_membership_page.loadLibrary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
