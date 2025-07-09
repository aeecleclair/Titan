import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/flappybird/ui/pages/game_page/game_page.dart'
    deferred as play_page;
import 'package:titan/flappybird/ui/pages/leaderboard_page/leaderboard_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FlappyBirdRouter {
  final Ref ref;
  static const String root = '/flappybird';
  static const String leaderBoard = '/leaderboard';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleFlappyBird,
    description: "Jouer à Flappy Bird et consulter le classement",
    root: FlappyBirdRouter.root,
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
