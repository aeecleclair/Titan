import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/providers/game_provider.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/elocaps/tools/functions.dart';
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
    final gameNotifier = ref.watch(gameProvider.notifier);
    final historyNotifier = ref.read(playerHistoProvider.notifier);
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            scoreToColor(
                firstTeam.fold<int>(0,
                    (previousValue, element) => previousValue + element.score),
                game.isConfirmed,
                game.isCancelled)[0],
            scoreToColor(
                firstTeam.fold<int>(0,
                    (previousValue, element) => previousValue + element.score),
                game.isConfirmed,
                game.isCancelled)[1],
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          const SizedBox(height: 10),
          Text(
              "${game.mode.name} - ${processDatePrint(game.timestamp.toString().split(" ")[0])}",
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
                    scoreToWinOrLose(firstTeam.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue + element.score)),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    scoreToWinOrLose(secondTeam.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue + element.score)),
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await gameNotifier.validateGame(game);
                          await historyNotifier.loadHisto(me.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.white, width: 1)),
                          ),
                          child: const Text(ElocapsTextConstant.validate,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await gameNotifier.cancelledGame(game);
                          await historyNotifier.loadHisto(me.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.white, width: 1)),
                          ),
                          child: const Text(ElocapsTextConstant.cancel,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ]),
            const SizedBox(height: 10),
          ] else if (game.isCancelled)
            const Text(ElocapsTextConstant.cancelledGame,
                style: TextStyle(color: Colors.white)),
        ]));
  }
}
