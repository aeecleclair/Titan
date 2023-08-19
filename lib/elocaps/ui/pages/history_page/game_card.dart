import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/tools/functions.dart';

class GameCard extends HookConsumerWidget {
  const GameCard({Key? key, required this.game}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      margin: const EdgeInsets.all(5),
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 115, 3, 3),
          Color.fromARGB(255, 231, 84, 31),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Text(
        "${capsModeToString(game.mode)}\n${game.timestamp.toString()}",
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 255, 252, 251),
        ),
      )),
    );
  }
}
