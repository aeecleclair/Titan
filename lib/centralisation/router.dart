import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/centralisation/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralisationRouter {
  final Ref ref;
  static const String root = '/centralisation';
  static final Module module = Module(
    name: CentralisationTextConstants.centralisation,
    icon: const Left(HeroIcons.link),
    root: CentralisationRouter.root,
    selected: false,
  );
  CentralisationRouter(this.ref);

  QRoute route() => QRoute(
    name: "centralisation",
    path: CentralisationRouter.root,
    builder: () => main_page.CentralisationMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
  );
}
