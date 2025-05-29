import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/flappybird/ui/pages/game_page/game_page.dart'
    deferred as play_page;
import 'package:myecl/flappybird/ui/pages/leaderboard_page/leaderboard_page.dart'
    deferred as main_page;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FlappyBirdRouter {
  final Ref ref;
  static const String root = '/flappybird';
  static const String leaderBoard = '/leaderboard';
  static final Module module = Module(
    name: "FlappyBird",
    icon: const Right("assets/images/logo_flappybird.svg"),
    root: FlappyBirdRouter.root,
    selected: false,
  );
  FlappyBirdRouter(this.ref);

  QRoute route() => QRoute(
    name: "flappybird",
    path: FlappyBirdRouter.root,
    builder: () => play_page.GamePage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(play_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: leaderBoard,
        builder: () => main_page.LeaderBoardPage(),
        middleware: [DeferredLoadingMiddleware(main_page.loadLibrary)],
      ),
    ],
  );
}
