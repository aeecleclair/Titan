
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/elocaps/ui/pages/main_page/main_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ElocapsRouter{
  final ProviderRef ref;
  static const String root = '/elocaps';
  static final Module module = Module(
      name: "Elocaps",
      icon: HeroIcons.gift,
      root: ElocapsRouter.root,
      selected: false);
  ElocapsRouter(this.ref);

  QRoute route() => QRoute(
        path: ElocapsRouter.root,
        builder: () => const EloCapsMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
      );
}