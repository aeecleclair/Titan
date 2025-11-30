import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/ticketing/ui/pages/main_page/main_page.dart';
import 'package:titan/ticketing/ui/pages/main_page/list_session_ui.dart';
import 'package:titan/ticketing/ui/pages/admin/admin_page.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketingRouter {
  final Ref ref;
  static const String root = '/ticketing';
  static const String admin = '/admin';
  static const String listSession = '/list_session';
  static const String addEditMember = '/add_edit_member';
  static final Module module = Module(
    name: "Ticketing",
    icon: const Left(HeroIcons.bolt),
    root: TicketingRouter.root,
    selected: false,
  );
  TicketingRouter(this.ref);

  QRoute route() => QRoute(
    name: "ticketing",
    path: TicketingRouter.root,
    builder: () => const TicketingMainPage(),
    middleware: [AuthenticatedMiddleware(ref)],
    children: [
      QRoute(
        path: admin,
        builder: () => const AdminPage(),
        middleware: [AdminMiddleware(ref, isAdminProvider)],
        // children: [
        //   QRoute(
        //     path: editAssociation,
        //     builder: () => AssociationEditorPage(),
        //     children: [
        //       QRoute(
        //         path: addEditMember,
        //         builder: () => const MembershipEditorPage(),
        //       ),
        //     ],
        //   ),
        //   QRoute(
        //     path: createAssociaiton,
        //     builder: () => AssociationCreationPage(),
        //   ),
        // ],
      ),
      // QRoute(
      //   path: listSession,
      //   builder: () => list_session_ui.,
      //   middleware: [DeferredLoadingMiddleware(list_products_page.loadLibrary)],
      // ),
      // QRoute(
      //   path: associationDetail,
      //   builder: () => const AssociationPage(),
      //   children: [
      //     QRoute(
      //       path: editAssociation,
      //       builder: () => AssociationEditorPage(),
      //       middleware: [
      //         AdminMiddleware(ref, isAssociationPresidentProvider),
      //       ],
      //       children: [
      //         QRoute(
      //           path: addEditMember,
      //           builder: () => const MembershipEditorPage(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      // QRoute(path: memberDetail, builder: () => const MemberDetailPage()),
    ],
  );
}
