import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/ui/pages/add_edit_groupement_page/groupement_add_edit_page.dart'
    deferred as groupement_add_edit_page;
import 'package:titan/phonebook/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/phonebook/ui/pages/association_add_edit_page/association_add_edit_page.dart'
    deferred as association_add_edit_page;
import 'package:titan/phonebook/ui/pages/association_groups_page/association_groups_page.dart'
    deferred as association_groups_page;
import 'package:titan/phonebook/ui/pages/association_members_page/association_members_page.dart'
    deferred as association_members_page;
import 'package:titan/phonebook/ui/pages/association_page/association_page.dart'
    deferred as association_page;
import 'package:titan/phonebook/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/phonebook/ui/pages/member_detail_page/member_detail_page.dart'
    deferred as member_detail_page;
import 'package:titan/phonebook/ui/pages/membership_editor_page/membership_editor_page.dart'
    deferred as membership_editor_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';

class PhonebookRouter {
  final Ref ref;
  static const String root = '/phonebook';
  static const String admin = '/admin';
  static const String addEditGroupement = '/add_edit_groupement';
  static const String addEditAssociation = '/add_edit_association';
  static const String editAssociationMembers = '/edit_association_members';
  static const String editAssociationGroups = '/edit_association_groups';
  static const String associationDetail = '/association_detail';
  static const String memberDetail = '/member_detail';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.modulePhonebook,
    getDescription: (context) =>
        AppLocalizations.of(context)!.modulePhonebookDescription,
    root: PhonebookRouter.root,
  );
  PhonebookRouter(this.ref);

  QRoute route() => QRoute(
    name: "phonebook",
    path: PhonebookRouter.root,
    builder: () => main_page.PhonebookMainPage(),
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
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, hasPhonebookAdminAccessProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: addEditAssociation,
            builder: () => association_add_edit_page.AssociationAddEditPage(),
            middleware: [
              DeferredLoadingMiddleware(association_add_edit_page.loadLibrary),
            ],
            children: [
              QRoute(
                path: addEditGroupement,
                builder: () =>
                    groupement_add_edit_page.AssociationGroupementAddEditPage(),
                middleware: [
                  DeferredLoadingMiddleware(
                    groupement_add_edit_page.loadLibrary,
                  ),
                ],
              ),
            ],
          ),

          QRoute(
            path: editAssociationMembers,
            builder: () => association_members_page.AssociationMembersPage(),
            middleware: [
              DeferredLoadingMiddleware(association_members_page.loadLibrary),
            ],
            children: [
              QRoute(
                path: addEditMember,
                builder: () => membership_editor_page.MembershipEditorPage(),
                middleware: [
                  DeferredLoadingMiddleware(membership_editor_page.loadLibrary),
                ],
              ),
            ],
          ),
          QRoute(
            path: editAssociationGroups,
            builder: () => association_groups_page.AssociationGroupsPage(),
            middleware: [
              DeferredLoadingMiddleware(association_groups_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: associationDetail,
        builder: () => association_page.AssociationPage(),
        middleware: [DeferredLoadingMiddleware(association_page.loadLibrary)],
        children: [
          QRoute(
            path: addEditAssociation,
            builder: () => association_add_edit_page.AssociationAddEditPage(),
            middleware: [
              DeferredLoadingMiddleware(association_add_edit_page.loadLibrary),
              AdminMiddleware(ref, isAssociationPresidentProvider),
            ],
            children: [
              QRoute(
                path: addEditGroupement,
                builder: () =>
                    groupement_add_edit_page.AssociationGroupementAddEditPage(),
                middleware: [
                  DeferredLoadingMiddleware(
                    groupement_add_edit_page.loadLibrary,
                  ),
                  AdminMiddleware(ref, isPhonebookAdminProvider),
                ],
              ),
            ],
          ),
          QRoute(
            path: editAssociationMembers,
            builder: () => association_members_page.AssociationMembersPage(),
            middleware: [
              DeferredLoadingMiddleware(association_members_page.loadLibrary),
              AdminMiddleware(ref, isAssociationPresidentProvider),
            ],
            children: [
              QRoute(
                path: addEditMember,
                builder: () => membership_editor_page.MembershipEditorPage(),
                middleware: [
                  DeferredLoadingMiddleware(membership_editor_page.loadLibrary),
                  AdminMiddleware(ref, isAssociationPresidentProvider),
                ],
              ),
            ],
          ),
        ],
      ),
      QRoute(
        path: memberDetail,
        builder: () => member_detail_page.MemberDetailPage(),
        middleware: [DeferredLoadingMiddleware(member_detail_page.loadLibrary)],
      ),
    ],
  );
}
