import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myecl/flap/ui/score.dart';

import 'bird.dart';
import 'pipe.dart';

var _pipeWidth = 80.0; // width of the pipe);
var _birdY = 0.0;

var _gameStarted = false;

void _startGame() {
  _gameStarted = true;
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    setState(() {
      _birdY -= 0.05;
    });
  });
}

void setState(Null Function() param0) {}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _gameStarted ? null : _startGame,
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
                    child: const Bird(birdSize: 50),
                  ),
                  Pipe(
                    pipeHeight: 300,
                    pipeWidth: _pipeWidth,
                    isBottomPipe: true,
                    xPipeAlignment: 0.5,
                  ),
                  Pipe(
                    pipeHeight: 150,
                    pipeWidth: _pipeWidth,
                    xPipeAlignment: 0.5,
                  ),
                  Container(
                    alignment: const Alignment(0, -0.4),
                    child: const Text(
                      'T A P  T O  P L A Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.orange,
              child: const GameScore(),
            ),
          ),
        ],
      ),
    );
  }
}
