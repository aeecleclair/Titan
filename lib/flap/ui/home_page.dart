import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/providers/bird_provider.dart';
import 'package:myecl/flap/providers/game_loop_provider.dart';
import 'package:myecl/flap/providers/game_state_provider.dart';
import 'package:myecl/flap/providers/pipe_list_provider.dart';
import 'package:myecl/flap/ui/bird.dart';
import 'package:myecl/flap/ui/pipe_handler.dart';
import 'package:myecl/flap/ui/score.dart';
import 'package:myecl/flap/ui/start_screen.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStarted = ref.watch(gameStateProvider);
    final gameStartNotifier = ref.read(gameStateProvider.notifier);
    final birdNotifier = ref.watch(birdProvider.notifier);
    final bird = ref.watch(birdProvider);
    final pipes = ref.watch(pipeListProvider);
    final pipeListNotifier = ref.read(pipeListProvider.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);

    final pipePassed = useState(false);
    final width = MediaQuery.of(context).size.width;

    void showGameOverDialog(void Function(Timer) gameLoop) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                timerNotifier.restart(gameLoop);
              },
              child: AlertDialog(
                backgroundColor: Colors.brown,
                title: Center(
                  child: Text(
                    'Game over!'.toUpperCase(),
                    style: GoogleFonts.silkscreen(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
                actions: [
                  MaterialButton(
                    color: Colors.grey[100],
                    onPressed: () {
                      timerNotifier.restart(gameLoop);
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.brown,
                    ),
                  )
                ],
                actionsAlignment: MainAxisAlignment.center,
              ),
            );
          });
    }

    void gameLoop(Timer timer, double height) {
      final newBird = birdNotifier.update();
      final newPipes = pipeListNotifier.update();
      for (int i = 0; i < newPipes.length; i++) {
        if (newPipes[i].position < -0.37) {
          if (!pipePassed.value) {
            birdNotifier.increaseScore();
            // if (bird.score > scoreRecord) {
            //   // scoreRecord = score;
            // }
            // _checkScoreRecord(bird.score);
            pipePassed.value = true;
          }
        }
        if (newPipes[i].position < -2) {
          pipePassed.value = false;
        }
      }
      pipeListNotifier.resetPipe();
      if (newBird.birdPosition > 1 ||
          newBird.birdPosition < -1 ||
          pipeListNotifier.birdHitPipe(width, height, newBird)) {
        timerNotifier.stop();
        birdNotifier.resetBird();
        pipeListNotifier.clearPipe();
        // showGameOverDialog();
        gameStartNotifier.setState(false);
      }
    }

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: LayoutBuilder(builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                if (!gameStarted) {
                  gameStartNotifier.setState(true);
                  timerNotifier
                      .start((timer) => gameLoop(timer, constraints.maxHeight));
                } else {
                  birdNotifier.jump();
                }
              },
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    const BirdDisplay(),
                    PipeHandler(constraints: constraints.maxHeight),
                    const StartScreen()
                  ],
                ),
              ),
            );
          }),
        ),
        const GameScore(),
      ],
    );
  }
}
