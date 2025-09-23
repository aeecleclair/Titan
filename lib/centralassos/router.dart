import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/centralassos/tools/constants.dart';
import 'package:myecl/centralassos/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralassociationRouter {
  final Ref ref;
  static const String root = '/centralassociation';
  static final Module module = Module(
    name: CentralassociationTextConstants.centralassociation,
    icon: const Left(HeroIcons.atSymbol),
    root: CentralassociationRouter.root,
    selected: false,
  );
  CentralassociationRouter(this.ref);

  QRoute route() => QRoute(
        name: "centralassociation",
        path: CentralassociationRouter.root,
        builder: () => main_page.CentralassociationMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
      );
}
