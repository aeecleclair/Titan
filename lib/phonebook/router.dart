import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/ui/pages/add_edit_groupement/add_edit_groupement_page.dart'
    deferred as add_edit_groupement_page;
import 'package:titan/phonebook/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/phonebook/ui/pages/association_creation_page/association_creation_page.dart'
    deferred as association_creation_page;
import 'package:titan/phonebook/ui/pages/association_editor_page/association_editor_page.dart'
    deferred as association_editor_page;
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
  static const String createAssociaiton = '/create_association';
  static const String editAssociation = '/edit_association';
  static const String associationDetail = '/association_detail';
  static const String memberDetail = '/member_detail';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    name: "Annuaire",
    icon: const Left(HeroIcons.phone),
    root: PhonebookRouter.root,
    selected: false,
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
            path: editAssociation,
            builder: () => association_editor_page.AssociationEditorPage(),
            middleware: [
              DeferredLoadingMiddleware(association_editor_page.loadLibrary),
            ],
            children: [
              QRoute(
                path: addEditMember,
                builder: () => membership_editor_page.MembershipEditorPage(),
              ),
            ],
          ),
          QRoute(
            path: createAssociaiton,
            builder: () => association_creation_page.AssociationCreationPage(),
            middleware: [
              DeferredLoadingMiddleware(association_creation_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addEditGroupement,
            builder: () =>
                add_edit_groupement_page.AssociationGroupementAddEditPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_groupement_page.loadLibrary),
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
            path: editAssociation,
            builder: () => association_editor_page.AssociationEditorPage(),
            middleware: [
              AdminMiddleware(ref, isAssociationPresidentProvider),
              DeferredLoadingMiddleware(association_editor_page.loadLibrary),
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
