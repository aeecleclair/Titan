import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/rplace/ui/pages/main.dart' deferred as main_page;
import 'package:myecl/tools/middlewares/deferred_middleware.dart';

class rPlaceRouter {
  final Ref ref;
  static const String root = '/rplace';
  static final Module module = Module(
      name: "rPlace",
      icon: const Left(HeroIcons.ticket),
      root: rPlaceRouter.root,
      selected: false);
  rPlaceRouter(this.ref);

  QRoute route() => QRoute(
          name: "rPlace",
          path: rPlaceRouter.root,
          builder: () => main_page.rPlacePage(),
          middleware: [
            AuthenticatedMiddleware(ref),
            DeferredLoadingMiddleware(main_page.loadLibrary),
          ]);
}
