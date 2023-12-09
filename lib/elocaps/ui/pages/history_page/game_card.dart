import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/tools/functions.dart';

class GameCard extends HookConsumerWidget {
  const GameCard({Key? key, required this.game}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstTeam = game.gamePlayers.where((element) => element.team == 1);
    final secondTeam = game.gamePlayers.where((element) => element.team == 2);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 115, 3, 3),
          Color.fromARGB(255, 231, 84, 31),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
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
                    firstTeam
                        .fold<int>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.quarters)
                        .toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    secondTeam
                        .fold<int>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.quarters)
                        .toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
