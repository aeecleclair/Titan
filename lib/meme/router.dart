import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/meme/ui/my_meme_tab/add_meme_page.dart/add_meme_page.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/meme/ui/main_page/main_page.dart' deferred as main_page;

class MemeRouter {
  final Ref ref;
  static const String root = '/Meme';
  static const String add = '/add';
  static final Module module = Module(
    name: "Meme",
    icon: const Left(HeroIcons.newspaper),
    root: MemeRouter.root,
    selected: false,
  );
  MemeRouter(this.ref);
  QRoute route() => QRoute(
        name: "Meme",
        path: MemeRouter.root,
        builder: () => main_page.MemeMainPage(),
        middleware: [
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: add,
            builder: () => const AddMemePage(),
          ),
        ],
      );
}
