import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/centralassociation/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralassociationRouter {
  final Ref ref;
  static const String root = '/centralassociation';
  static final Module module = Module(
    getName: (context) =>
        AppLocalizations.of(context)!.moduleCentralassociation,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleCentralassociationDescription,
    root: CentralassociationRouter.root,
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
