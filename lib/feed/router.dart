import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/feed/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FeedRouter {
  final Ref ref;

  static const String root = '/feed';
  static final Module module = Module(
    name: "Feed",
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
  );
}
