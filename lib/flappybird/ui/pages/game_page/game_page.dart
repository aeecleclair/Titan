import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/class/score.dart';
import 'package:titan/flappybird/providers/bird_provider.dart';
import 'package:titan/flappybird/providers/current_best_score.dart';
import 'package:titan/flappybird/providers/game_loop_provider.dart';
import 'package:titan/flappybird/providers/game_state_provider.dart';
import 'package:titan/flappybird/providers/pipe_list_provider.dart';
import 'package:titan/flappybird/providers/score_list_provider.dart';
import 'package:titan/flappybird/ui/flappybird_template.dart';
import 'package:titan/flappybird/ui/pages/game_page/pipe_handler.dart';
import 'package:titan/flappybird/ui/pages/game_page/score.dart';
import 'package:titan/flappybird/ui/pages/game_page/start_screen.dart';

import 'bird.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStarted = ref.watch(gameStateProvider);
    final gameStartNotifier = ref.read(gameStateProvider.notifier);
    final birdNotifier = ref.watch(birdProvider.notifier);
    final pipeListNotifier = ref.read(pipeListProvider.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final scoreListNotifier = ref.read(scoreListProvider.notifier);

    final pipePassed = useState(false);
    final bestScore = ref.watch(bestScoreProvider);
    final bestScoreNotifier = ref.read(bestScoreProvider.notifier);
    final width = MediaQuery.of(context).size.width;

    void showGameOverDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              birdNotifier.resetBird();
              pipeListNotifier.clearPipe();
              Navigator.of(context).pop();
            },
            child: AlertDialog(
              backgroundColor: Colors.brown,
              title: Center(
                child: Text(
                  'Game over!'.toUpperCase(),
                  style: GoogleFonts.silkscreen(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: MaterialButton(
                    color: Colors.grey[100],
                    onPressed: () {
                      birdNotifier.resetBird();
                      pipeListNotifier.clearPipe();
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.refresh, color: Colors.brown),
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        },
      );
    }

    void gameLoop(Timer timer, double height) {
      final newBird = birdNotifier.update();
      final newPipes = pipeListNotifier.update();
      for (int i = 0; i < newPipes.length; i++) {
        if (newPipes[i].position < -0.37 &&
            newPipes[i].position > -0.63 &&
            !newPipes[i].isPassed) {
          birdNotifier.increaseScore();
          if (newBird.score + 1 > bestScore) {
            bestScoreNotifier.setBest(newBird.score + 1);
          }
          pipeListNotifier.setIsPassed(i);
          break;
        }
      }

      pipeListNotifier.resetPipe();
      if ((newBird.birdPosition).abs() > 1 ||
          pipeListNotifier.birdHitPipe(width, height, newBird)) {
        timerNotifier.stop();
        if (newBird.score > bestScore) {
          scoreListNotifier.createScore(
            Score(
              user: newBird.user,
              value: newBird.score,
              date: DateTime.now(),
              position: 0,
            ),
          );
        }
        showGameOverDialog();
        gameStartNotifier.setState(false);
      }
    }

    return FlappyBirdTemplate(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onTapDown: (details) {
                    if (!gameStarted) {
                      gameStartNotifier.setState(true);
                      pipePassed.value = false;
                      timerNotifier.start(
                        (timer) => gameLoop(timer, constraints.maxHeight),
                      );
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
                        const StartScreen(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const GameScore(),
        ],
      ),
    );
  }
}
