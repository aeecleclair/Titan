import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/providers/is_admin_provider.dart';

import 'package:titan/super_admin/ui/pages/edit_module_visibility/edit_module_visibility.dart'
    deferred as edit_module_visibility;

import 'package:titan/super_admin/ui/pages/memberships/add_edit_user_membership_page/add_edit_user_membership_page.dart'
    deferred as add_edit_user_membership_page;
import 'package:titan/super_admin/ui/pages/memberships/association_membership_detail_page/association_membership_detail_page.dart'
    deferred as association_membership_detail_page;
import 'package:titan/super_admin/ui/pages/memberships/association_membership_page/association_membership_page.dart'
    deferred as association_membership_page;
import 'package:titan/super_admin/ui/pages/schools/school_page/school_page.dart'
    deferred as school_page;
import 'package:titan/super_admin/ui/pages/schools/add_school_page/add_school_page.dart'
    deferred as add_school_page;
import 'package:titan/super_admin/ui/pages/schools/edit_school_page/edit_school_page.dart'
    deferred as edit_school_page;
import 'package:titan/super_admin/ui/pages/structure_page/structure_page.dart'
    deferred as structure_page;
import 'package:titan/super_admin/ui/pages/add_edit_structure_page/add_edit_structure_page.dart'
    deferred as add_edit_structure_page;
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
  static const String editModuleVisibility = '/edit_module_visibility';
  static const String associationMemberships = '/association_memberships';
  static const String detailAssociationMembership =
      '/detail_association_membership';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    getName: (context) => "Super Admin",
    description: "Gérer les groupes, écoles et structures",
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
        path: editModuleVisibility,
        builder: () => edit_module_visibility.EditModulesVisibilityPage(),
        middleware: [
          DeferredLoadingMiddleware(edit_module_visibility.loadLibrary),
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
