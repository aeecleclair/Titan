import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/flap/ui/pages/game_page/game_page.dart'
    deferred as play_page;
import 'package:myecl/flap/ui/pages/leaderboard_page/leaderboard_page.dart'
    deferred as main_page;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FlapRouter {
  final ProviderRef ref;
  static const String root = '/flap';
  static const String leaderBoard = '/leaderboard';
  static final Module module = Module(
    name: "FlappyBird",
    icon: const Right("assets/images/flap.svg"),
    root: FlapRouter.root,
    selected: false,
  );
  FlapRouter(this.ref);

  QRoute route() => QRoute(
        name: "flap",
        path: FlapRouter.root,
        builder: () => play_page.GamePage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(play_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: leaderBoard,
            builder: () => main_page.LeaderBoardPage(),
            middleware: [
              DeferredLoadingMiddleware(main_page.loadLibrary),
            ],
          ),
        ],
      );
}
