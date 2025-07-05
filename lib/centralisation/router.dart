import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/centralisation/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralisationRouter {
  final Ref ref;
  static const String root = '/centralisation';
  static final Module module = Module(
    description: "Gérer la centralisation des données",
    name: CentralisationTextConstants.centralisation,
    root: CentralisationRouter.root,
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
