import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/centralassos/tools/constants.dart';
import 'package:titan/centralassos/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralassosRouter {
  final Ref ref;
  static const String root = '/centralassociation';
  static final Module module = Module(
    name: CentralassosTextConstants.centralassos,
    icon: const Left(HeroIcons.atSymbol),
    root: CentralassosRouter.root,
    selected: false,
  );
  CentralassosRouter(this.ref);

  QRoute route() => QRoute(
    name: "centralassociation",
    path: CentralassosRouter.root,
    builder: () => main_page.CentralassosMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
  );
}
