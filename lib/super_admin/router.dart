import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/providers/is_super_admin_provider.dart';
import 'package:titan/super_admin/ui/pages/permissions/permissions.dart'
    deferred as permissions;
import 'package:titan/super_admin/ui/pages/super_admins_page/super_admins_page.dart'
    deferred as super_admins_page;

import 'package:titan/super_admin/ui/pages/schools/school_page/school_page.dart'
    deferred as school_page;
import 'package:titan/super_admin/ui/pages/schools/add_school_page/add_school_page.dart'
    deferred as add_school_page;
import 'package:titan/super_admin/ui/pages/schools/edit_school_page/edit_school_page.dart'
    deferred as edit_school_page;
import 'package:titan/super_admin/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SuperAdminRouter {
  final Ref ref;
  static const String root = '/super_admin';
  static const String groups = '/groups';
  static const String addGroup = '/add_group';
  static const String editGroup = '/edit_group';
  static const String addLoaner = '/add_loaner';
  static const String schools = '/schools';
  static const String addSchool = '/add_school';
  static const String editSchool = '/edit_school';
  static const String structures = '/structures';
  static const String addEditStructure = '/add_edit_structure';
  static const String editPermissions = '/edit_permissions';
  static const String superAdmins = '/super_admins';
  static const String associationMemberships = '/association_memberships';
  static const String detailAssociationMembership =
      '/detail_association_membership';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    getName: (context) => "Super Admin",
    getDescription: (context) => "Super Admin",
    root: SuperAdminRouter.root,
  );
  SuperAdminRouter(this.ref);

  QRoute route() => QRoute(
    name: "super_admin",
    path: SuperAdminRouter.root,
    builder: () => main_page.SuperAdminMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      AdminMiddleware(ref, isSuperAdminProvider),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: editPermissions,
        builder: () => permissions.PermissionsPage(),
        middleware: [DeferredLoadingMiddleware(permissions.loadLibrary)],
      ),
      QRoute(
        path: superAdmins,
        builder: () => super_admins_page.SuperAdminsPage(),
        middleware: [
          DeferredLoadingMiddleware(super_admins_page.loadLibrary),
        ],
      ),
      QRoute(
        path: schools,
        builder: () => school_page.SchoolsPage(),
        middleware: [DeferredLoadingMiddleware(school_page.loadLibrary)],
        children: [
          QRoute(
            path: addSchool,
            builder: () => add_school_page.AddSchoolPage(),
            middleware: [
              DeferredLoadingMiddleware(add_school_page.loadLibrary),
            ],
          ),
          QRoute(
            path: editSchool,
            builder: () => edit_school_page.EditSchoolPage(),
            middleware: [
              DeferredLoadingMiddleware(edit_school_page.loadLibrary),
            ],
          ),
        ],
      ),
    ],
  );
}
