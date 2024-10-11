import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/home/ui/home.dart' deferred as home_page;
import 'package:myecl/tools/class/module_router.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HomeRouter extends ModuleRouter {
  static const String root = '/home';
  static final Module module = Module(
    name: "Accueil",
    icon: const Left(HeroIcons.home),
    root: HomeRouter.root,
    selected: false,
  );
  HomeRouter(super.ref);

  @override
  QRoute route() => QRoute(
        name: "home",
        path: HomeRouter.root,
        builder: () => home_page.HomePage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(home_page.loadLibrary),
        ],
      );
}
