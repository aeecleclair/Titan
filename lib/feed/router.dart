import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/feed/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/feed/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FeedRouter {
  final Ref ref;

  static const String root = '/feed';
  static const String admin = '/admin';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleFeed,
    description: "Consulter les actualités et mises à jour",
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
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
      ),
    ],
  );
}
