import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tickets/providers/is_user_a_member_of_a_store.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tickets/ui/pages/tickets_main_page.dart' deferred as main_page;
import 'package:titan/tickets/ui/pages/book_ticket_page.dart'
    deferred as book_ticket_page;
import 'package:titan/tickets/ui/pages/create_ticket_event_page.dart'
    deferred as create_ticket_page;
import 'package:titan/tickets/ui/pages/manage_ticket_event_page.dart'
    deferred as manage_ticket_page;
import 'package:titan/tickets/ui/pages/edit_ticket_event_page.dart'
    deferred as edit_ticket_page;
import 'package:titan/tickets/ui/pages/ticket_results_page.dart'
    deferred as ticket_results_page;

class TicketsRouter {
  final Ref ref;
  static const String root = '/tickets';
  static const String book = '/book';
  static const String create = '/create';
  static const String createQuotas = 'quotas';
  static const String manage = '/manage';
  static const String edit = '/edit';
  static const String results = '/results';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.ticketsTickets,
    getDescription: (context) =>
        AppLocalizations.of(context)!.ticketsTicketsDescription,
    root: TicketsRouter.root,
  );
  TicketsRouter(this.ref);

  QRoute route() => QRoute(
    name: "tickets",
    path: TicketsRouter.root,
    builder: () => main_page.TicketsMainPage(),
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
        builder: () => create_ticket_page.CreateTicketEventPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(create_ticket_page.loadLibrary),
        ],
      ),
      QRoute(
        path: manage,
        builder: () => manage_ticket_page.ManageTicketEventPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(manage_ticket_page.loadLibrary),
        ],
      ),
      QRoute(
        path: edit,
        builder: () => edit_ticket_page.EditTicketEventPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAStoreProvider),
          DeferredLoadingMiddleware(edit_ticket_page.loadLibrary),
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
