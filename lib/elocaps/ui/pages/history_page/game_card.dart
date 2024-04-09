import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/providers/game_provider.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/elocaps/ui/pages/history_page/button_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_provider.dart';

class GameCard extends HookConsumerWidget {
  const GameCard({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final myTeamNumber = game.gamePlayers
        .where((element) => element.playerId == me.id)
        .first
        .team;
    final firstTeam =
        game.gamePlayers.where((element) => element.team == myTeamNumber);
    final secondTeam =
        game.gamePlayers.where((element) => element.team == 3 - myTeamNumber);
    final firstTeamScore = firstTeam.fold<int>(
        0, (previousValue, element) => previousValue + element.score);
    final secondTeamScore = secondTeam.fold<int>(
        0, (previousValue, element) => previousValue + element.score);
    final gameNotifier = ref.watch(gameProvider.notifier);
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: scoreToColor(
                  firstTeamScore, game.isConfirmed, game.isCancelled),
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          const SizedBox(height: 10),
          Text(
              "${capsModeToString(game.mode)} - ${processDatePrint(game.timestamp.toString().split(" ")[0])}",
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    firstTeam
                        .map((e) => e.user.nickname ?? e.user.firstname)
                        .join(" - "),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    secondTeam
                        .map((e) => e.user.nickname ?? e.user.firstname)
                        .join(" - "),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    scoreToWinOrLose(firstTeamScore),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    scoreToWinOrLose(secondTeamScore),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (!game.isConfirmed && !game.isCancelled) ...[
            game.gamePlayers
                    .where((element) => element.playerId == me.id)
                    .first
                    .hasConfirmed
                ? const Text(ElocapsTextConstant.waitingOppositeTeamApproval,
                    style: TextStyle(color: Colors.white))
                : Row(children: [
                    ButtonCard(
                        game: game,
                        validateOrCancelledGame: gameNotifier.validateGame,
                        validateOrCancelled: ElocapsTextConstant.validate),
                    ButtonCard(
                        game: game,
                        validateOrCancelledGame: gameNotifier.cancelledGame,
                        validateOrCancelled: ElocapsTextConstant.cancel)
                  ]),
            const SizedBox(height: 10),
          ] else if (game.isCancelled)
            const Text(ElocapsTextConstant.cancelledGame,
                style: TextStyle(color: Colors.white)),
        ]));
  }
}
