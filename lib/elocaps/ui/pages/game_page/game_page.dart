import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/game_page/mode_dialog.dart';
import 'package:myecl/elocaps/ui/pages/game_page/player_form.dart';


class GamePage extends HookConsumerWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 3000), initialValue: 0)
      ..repeat(reverse: true);

    final modeChosen = ref.watch(modeChosenProvider);
    final players = [
      PlayerForm(num: 1, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 2, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 3, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 4, queryController: useTextEditingController(text: "")),
    ];


    return ElocapsTemplate(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              children: [
          const SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModeDialog(players: players,
                    );
                  },
                );
              },
              child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {return Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 7, 
                    )],
                    gradient: RadialGradient(
                              colors: const [
                                Color.fromARGB(255, 201, 34, 21),
                                Color.fromARGB(255, 248, 187, 55),
                                Color.fromARGB(255, 201, 34, 21),
                                Color.fromARGB(255, 176, 16, 4),
                              ],
                              stops: [
                                0.1 + 0.6 * animation.value,
                                0.25 + 0.6 * animation.value,
                                0.35 + 0.65 * animation.value,
                                1,
                              ],
                              radius: 2,
                              center: Alignment(0.65+math.cos(3*animation.value+math.pi/2),0.2-math.sin(animation.value)
                                  ),
                            )),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Mode actuel: ${modeChosen.toString().split('.').last}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 248, 248, 248))));}
                                )),
          Form(
            key: key,
            child: Column(
              children: modeChosen == CapsMode.cd
                            ? players
                            : players.sublist(0, 2),
            ),
          ),
          
          const SizedBox(height: 30),
          const MyButton(text: "Lancer la partie"),
              ],
            ),
        ));
  }
}
