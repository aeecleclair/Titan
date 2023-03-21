import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';
import 'package:myecl/flap/providers/bird_provider.dart';
import 'package:myecl/flap/providers/game_state_provider.dart';
import 'package:myecl/flap/ui/bird.dart';
import 'package:myecl/flap/ui/pipe_handler.dart';
import 'package:myecl/flap/ui/score.dart';
import 'package:myecl/flap/ui/start_screen.dart';

import 'pipe.dart';

const _pipeWidth = 80.0;

class GamePage extends HookConsumerWidget {
  GamePage({Key? key}) : super(key: key);

  int scoreRecord = 0;
  bool pipePassed = false;

  // late double height = MediaQuery.of(context).size.height * 0.75;
  // late final List<List<double>> _pipeHeights = [
  //   generateRandomPipeHeights(height),
  //   generateRandomPipeHeights(height),
  //   generateRandomPipeHeights(height),
  // ];

  // bool _birdHitPipe() {
  //   final width = MediaQuery.of(context).size.width;
  //   final height = MediaQuery.of(context).size.height * 0.75 / 2;

  //   for (int pipeNumber = 0; pipeNumber < xPipeAlignment.length; pipeNumber++) {
  //     if (xPipeAlignment[pipeNumber] - _pipeWidth / width <= -0.45 &&
  //         xPipeAlignment[pipeNumber] + _pipeWidth / width >= -0.65 &&
  //         (bird.birdPosition >= 1 - (_pipeHeights[pipeNumber][0]) / height ||
  //             bird.birdPosition <=
  //                 -1 + (_pipeHeights[pipeNumber][1]) / height)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // void restartGame() {
  //   setState(() {
  //     _gameStarted = false;
  //     pipePassed = false;
  //     xPipeAlignment = [1.0, 2.2, 3.4];
  //   });
  // }

  // void _showGameOverDialog() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //             restartGame();
  //           },
  //           child: AlertDialog(
  //             backgroundColor: Colors.brown,
  //             title: Center(
  //               child: Text(
  //                 'Game over!'.toUpperCase(),
  //                 style: GoogleFonts.silkscreen(
  //                     textStyle: const TextStyle(color: Colors.white)),
  //               ),
  //             ),
  //             actions: [
  //               MaterialButton(
  //                 color: Colors.grey[100],
  //                 onPressed: () {
  //                   restartGame();
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Icon(
  //                   Icons.refresh,
  //                   color: Colors.brown,
  //                 ),
  //               )
  //             ],
  //             actionsAlignment: MainAxisAlignment.center,
  //           ),
  //         );
  //       });
  // }

  // void _checkScoreRecord(int score) {
  //   if (score > scoreRecord) {
  //     scoreRecord = score;
  //   }
  // }

  // void countPoint() {
  //   for (int i = 0; i < xPipeAlignment.length; i++) {
  //     if (xPipeAlignment[i] < -0.37) {
  //       if (!pipePassed) {
  //         bird.score++;
  //         _checkScoreRecord(bird.score);
  //         pipePassed = true;
  //       }
  //     }
  //     if (xPipeAlignment[i] < -2) {
  //       xPipeAlignment[i] += 3.5;
  //       _pipeHeights[i] = generateRandomPipeHeights(
  //           MediaQuery.of(context).size.height * 0.75);
  //       pipePassed = false;
  //     } else {
  //       xPipeAlignment[i] -= 0.01;
  //     }
  //   }
  // }

  // void _startGame() {
  //   _gameStarted = true;
  //   Timer.periodic(const Duration(milliseconds: 10), (timer) {
  //     double height = _gravity * time * time + _velocity * time;
  //     setState(() {
  //       bird.birdPosition = initialPosition - height;
  //       countPoint();
  //     });
  //     if (_birdIsDead()) {
  //       timer.cancel();
  //       _showGameOverDialog();
  //     }
  //     time += 0.01;
  //   });
  // }

  // bool _birdIsDead() {
  //   return _birdHitGroundOrTop() || _birdHitPipe();
  // }

  // bool _birdHitGroundOrTop() {
  //   return bird.birdPosition > 1 || bird.birdPosition < -1;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStarted = ref.watch(gameStateProvider);
    final gameStartNotifier = ref.read(gameStateProvider.notifier);
    final birdNotifier = ref.watch(birdProvider.notifier);
    return GestureDetector(
      onTap: () {
        if (!gameStarted) {
          gameStartNotifier.setState(true);
        } else {
          birdNotifier.jump();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    const BirdDisplay(),
                    PipeHandler(constraints: constraints.maxHeight),
                    const StartScreen()
                  ],
                ),
              );
            }),
          ),
          const GameScore(),
        ],
      ),
    );
  }
}
