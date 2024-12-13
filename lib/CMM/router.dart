import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/CMM/ui/main_page/main_page.dart' deferred as main_page;

class CMMRouter {
  final ProviderRef ref;
  static const String root = '/CMM';
  static const String leaderboard = '/leaderboard';
  static const String add = '/add';
  static final Module module = Module(
    name: "CMM",
    icon: const Left(HeroIcons.newspaper),
    root: CMMRouter.root,
    selected: false,
  );
  CMMRouter(this.ref);
  QRoute route() => QRoute(
        name: "CMM",
        path: CMMRouter.root,
        builder: () => main_page.CMMMainPage(),
        middleware: [
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
      );
}
