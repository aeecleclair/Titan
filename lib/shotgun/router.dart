import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/shotgun/providers/is_user_a_member_of_a_store.dart';
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
import 'package:titan/shotgun/ui/pages/ticket_results_page.dart'
    deferred as ticket_results_page;

class ShotgunRouter {
  final Ref ref;
  static const String root = '/shotgun';
  static const String book = '/book';
  static const String create = '/create';
  static const String createQuotas = 'quotas';
  static const String manage = '/manage';
  static const String edit = '/edit';
  static const String results = '/results';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.shotgunShotgun,
    getDescription: (context) =>
        AppLocalizations.of(context)!.shotgunShotgunDescription,
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
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
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
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(create_shotgun_page.loadLibrary),
        ],
      ),
      QRoute(
        path: manage,
        builder: () => manage_shotgun_page.ManageShotgunPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(manage_shotgun_page.loadLibrary),
        ],
      ),
      QRoute(
        path: edit,
        builder: () => edit_shotgun_page.EditShotgunPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(edit_shotgun_page.loadLibrary),
        ],
      ),
      QRoute(
        path: results,
        builder: () => ticket_results_page.TicketResultsPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(ticket_results_page.loadLibrary),
        ],
      ),
    ],
  );
}
