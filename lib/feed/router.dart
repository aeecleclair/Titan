import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/feed/ui/pages/add_event_page/add_event_page.dart'
    deferred as add_event_page;
import 'package:titan/feed/ui/pages/event_handling_page/event_handling_page.dart'
    deferred as event_handling_page;
import 'package:titan/feed/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FeedRouter {
  final Ref ref;

  static const String root = '/feed';
  static const String addEvent = '/add_event';
  static const String eventHandling = '/event_handling';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleFeed,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleFeedDescription,
    root: FeedRouter.root,
  );

  FeedRouter(this.ref);

  QRoute route() => QRoute(
    name: "feed",
    path: FeedRouter.root,
    builder: () => main_page.FeedMainPage(),
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
        path: addEvent,
        builder: () => add_event_page.AddEventPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(add_event_page.loadLibrary),
        ],
      ),
      QRoute(
        path: eventHandling,  
        builder: () => event_handling_page.EventHandlingPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(event_handling_page.loadLibrary),
        ],
      ),
    ],
  );
}
