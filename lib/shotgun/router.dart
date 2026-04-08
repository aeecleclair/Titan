import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/providers/is_user_a_member_of_an_association.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/shotgun/ui/pages/main_page.dart' deferred as main_page;
import 'package:titan/shotgun/ui/pages/book_ticket_page.dart'
    deferred as book_ticket_page;
import 'package:titan/shotgun/ui/pages/create_shotgun_page.dart'
    deferred as create_shotgun_page;
import 'package:titan/shotgun/ui/pages/manage_shotgun_page.dart'
    deferred as manage_shotgun_page;
import 'package:titan/shotgun/ui/pages/edit_shotgun_page.dart'
    deferred as edit_shotgun_page;

class ShotgunRouter {
  final Ref ref;
  static const String root = '/shotgun';
  static const String book = '/book';
  static const String create = '/create';
  static const String createQuotas = 'quotas';
  static const String manage = '/manage';
  static const String edit = '/edit';
  static final Module module = Module(
    getName: (context) => "Shotgun",
    getDescription: (context) => "Shotgun",
    root: ShotgunRouter.root,
  );
  ShotgunRouter(this.ref);

  QRoute route() => QRoute(
    name: "shotgun",
    path: ShotgunRouter.root,
    builder: () => main_page.ShotgunMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: book,
        builder: () => book_ticket_page.BookTicketPage(),
        middleware: [DeferredLoadingMiddleware(book_ticket_page.loadLibrary)],
      ),
      QRoute(
        path: create,
        builder: () => create_shotgun_page.CreateShotgunPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAnAssociationProvider),
          DeferredLoadingMiddleware(create_shotgun_page.loadLibrary),
        ],
      ),
      QRoute(
        path: manage,
        builder: () => manage_shotgun_page.ManageShotgunPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAnAssociationProvider),
          DeferredLoadingMiddleware(manage_shotgun_page.loadLibrary),
        ],
      ),
      QRoute(
        path: edit,
        builder: () => edit_shotgun_page.EditShotgunPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAnAssociationProvider),
          DeferredLoadingMiddleware(edit_shotgun_page.loadLibrary),
        ],
      ),
    ],
  );
}
