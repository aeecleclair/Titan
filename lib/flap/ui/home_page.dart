import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myecl/flap/ui/score.dart';

import 'bird.dart';
import 'pipe.dart';

const _pipeWidth = 80.0;
const _gravity = -2;
const _velocity = 1;

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _MyGamePageState();
}

class _MyGamePageState extends State<GamePage> {
  double initialPosition = 0.0;
  double time = 0.0;
  double _birdY = 0.0;

  int score = 0;
  double angle = 0.0;
  int scoreRecord = 0;
  bool pipePassed = false;
  bool _gameStarted = false;
  List<double> xPipeAlignment = [
    1.0,
    2.2,
    3.4,
  ];
  late double height = MediaQuery.of(context).size.height * 0.75;
  late final List<List<double>> _pipeHeights = [
    generateRandomPipeHeights(height),
    generateRandomPipeHeights(height),
    generateRandomPipeHeights(height),
  ];

  List<double> generateRandomPipeHeights(double screenHeight) {
    final random = Random();
    final randomHeight = random.nextInt(300).toDouble() + 50;
    return [randomHeight, screenHeight - randomHeight - 200];
  }

  bool _birdHitPipe() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.75 / 2;

    for (int pipeNumber = 0; pipeNumber < xPipeAlignment.length; pipeNumber++) {
      if (xPipeAlignment[pipeNumber] - _pipeWidth / width <= -0.45 &&
          xPipeAlignment[pipeNumber] + _pipeWidth / width >= -0.65 &&
          (_birdY >= 1 - (_pipeHeights[pipeNumber][0]) / height ||
              _birdY <= -1 + (_pipeHeights[pipeNumber][1]) / height)) {
        return true;
      }
    }
    return false;
  }

  void restartGame() {
    setState(() {
      _birdY = 0.0;
      _gameStarted = false;
      pipePassed = false;
      score = 0;
      time = 0.0;
      angle = 0.0;
      initialPosition = 0.0;
      xPipeAlignment = [1.0, 2.2, 3.4];
    });
  }

  void _showGameOverDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              restartGame();
            },
            child: AlertDialog(
              backgroundColor: Colors.brown,
              title: Center(
                child: Text(
                  'Game over!'.toUpperCase(),
                  style: GoogleFonts.silkscreen(
                    textStyle:const TextStyle(color: Colors.white)),
                ),
              ),
              actions: [
                MaterialButton(
                  color: Colors.grey[100],
                  onPressed: () {
                    restartGame();
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

  void _checkScoreRecord(int score) {
    if (score > scoreRecord) {
      scoreRecord = score;
    }
  }

  void _startGame() {
    _gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      double height = _gravity * time * time + _velocity * time;
      setState(() {
        _birdY = initialPosition - height;
        for (int i = 0; i < xPipeAlignment.length; i++) {
          if (xPipeAlignment[i] < -0.37) {
            if (!pipePassed) {
              score++;
              _checkScoreRecord(score);
              pipePassed = true;
            }
          }
          if (xPipeAlignment[i] < -2) {
            xPipeAlignment[i] += 3.5;
            _pipeHeights[i] = generateRandomPipeHeights(
                MediaQuery.of(context).size.height * 0.75);
            pipePassed = false;
          } else {
            xPipeAlignment[i] -= 0.01;
            angle += 0.005;
          }
        }
      });
      if (_birdIsDead()) {
        timer.cancel();
        _showGameOverDialog();
      }
      time += 0.01;
    });
  }

  void _jump() {
    setState(() {
      initialPosition = _birdY;
      time = 0.0;
      angle = -pi / 4;
    });
  }

  bool _birdIsDead() {
    return _birdHitGroundOrTop() || _birdHitPipe();
  }

  bool _birdHitGroundOrTop() {
    return _birdY > 1 || _birdY < -1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
        onTap: () {
          if (!_gameStarted) {
            _startGame();
          } else {
            _jump();
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(-0.5, _birdY),
                      child: Bird(
                        birdSize: 50,
                        angle: angle,
                      ),
                    ),
                    ..._pipeHeights.map((e) => Stack(
                          children: [
                            Pipe(
                              pipeHeight: e[0],
                              pipeWidth: _pipeWidth,
                              isBottomPipe: true,
                              xPipeAlignment:
                                  xPipeAlignment[_pipeHeights.indexOf(e)],
                            ),
                            Pipe(
                              pipeHeight: e[1],
                              pipeWidth: _pipeWidth,
                              xPipeAlignment:
                                  xPipeAlignment[_pipeHeights.indexOf(e)],
                            )
                          ],
                        )),
                    if (!_gameStarted)
                      Container(
                        alignment: const Alignment(0, -0.4),
                        child:  Text(
                          'T A P  T O  P L A Y',
                          style: GoogleFonts.silkscreen(
                    textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),)
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  color: Colors.brown,
                  child: GameScore(
                    score: score,
                    scoreRecord: scoreRecord,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
