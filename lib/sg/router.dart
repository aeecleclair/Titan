import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/sg/ui/pages/main_page.dart' deferred as main_page;
import 'package:myecl/sg/ui/pages/admin_page.dart' deferred as admin_page;

class ShotgunRouter {
  final ProviderRef ref;
  static const String root = '/shotgun';
  static const String admin = '/admin';

  static final Module module = Module(
    name: "Shotgun",
    icon: const Left(HeroIcons.gift),
    root: ShotgunRouter.root,
    selected: false,
  );
  ShotgunRouter(this.ref);
  QRoute route() => QRoute(
        name: "shotgun",
        path: ShotgunRouter.root,
        builder: () => main_page.SgMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: admin,
            builder: () => admin_page.AdminPage(),
            middleware: [
              DeferredLoadingMiddleware(admin_page.loadLibrary),
            ],
          ),
        ],
      );
}
