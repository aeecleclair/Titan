import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/rplace/ui/pages/main.dart' deferred as main_page;
import 'package:titan/tools/middlewares/deferred_middleware.dart';

class RPlaceRouter {
  final Ref ref;
  static const String root = '/rplace';
  static final Module module = Module(
    name: "rPlace",
    icon: const Left(HeroIcons.ticket),
    root: RPlaceRouter.root,
    selected: false,
  );
  RPlaceRouter(this.ref);

  QRoute route() => QRoute(
    name: "rPlace",
    path: RPlaceRouter.root,
    builder: () => main_page.RPlacePage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
  );
}
