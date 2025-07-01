import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/ui/pages/admin_page/admin_page.dart';
import 'package:titan/phonebook/ui/pages/association_creation_page/association_creation_page.dart';
import 'package:titan/phonebook/ui/pages/association_editor_page/association_editor_page.dart';
import 'package:titan/phonebook/ui/pages/association_page/association_page.dart';
import 'package:titan/phonebook/ui/pages/main_page/main_page.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/member_detail_page.dart';
import 'package:titan/phonebook/ui/pages/membership_editor_page/membership_editor_page.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhonebookRouter {
  final Ref ref;
  static const String root = '/phonebook';
  static const String admin = '/admin';
  static const String createAssociaiton = '/create_association';
  static const String editAssociation = '/edit_association';
  static const String associationDetail = '/association_detail';
  static const String memberDetail = '/member_detail';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    name: "Annuaire",
    description: "Gérer les associations, les membres et les administrateurs",
    root: PhonebookRouter.root,
  );
  PhonebookRouter(this.ref);

  QRoute route() => QRoute(
    name: "phonebook",
    path: PhonebookRouter.root,
    builder: () => const PhonebookMainPage(),
    middleware: [AuthenticatedMiddleware(ref)],
    children: [
      QRoute(
        path: admin,
        builder: () => const AdminPage(),
        middleware: [AdminMiddleware(ref, hasPhonebookAdminAccessProvider)],
        children: [
          QRoute(
            path: editAssociation,
            builder: () => AssociationEditorPage(),
            children: [
              QRoute(
                path: addEditMember,
                builder: () => const MembershipEditorPage(),
              ),
            ],
          ),
          QRoute(
            path: createAssociaiton,
            builder: () => AssociationCreationPage(),
          ),
        ],
      ),
      QRoute(
        path: associationDetail,
        builder: () => const AssociationPage(),
        children: [
          QRoute(
            path: editAssociation,
            builder: () => AssociationEditorPage(),
            middleware: [AdminMiddleware(ref, isAssociationPresidentProvider)],
            children: [
              QRoute(
                path: addEditMember,
                builder: () => const MembershipEditorPage(),
              ),
            ],
          ),
        ],
      ),
      QRoute(path: memberDetail, builder: () => const MemberDetailPage()),
    ],
  );
}
