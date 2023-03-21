import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/class/pipe.dart';

class PipeListNotifier extends StateNotifier<List<Pipe>> {
  PipeListNotifier()
      : super([
          Pipe.random(position: 1),
          Pipe.random(position: 2.2),
          Pipe.random(position: 3.4),
        ]);

  List<Pipe> update() {
    return state = state.map((e) {
      return e.copyWith(position: e.position - 0.01);
    }).toList();
  }

  void resetPipe() {
    state = state.map((e) {
      if (e.position < -2) {
        return Pipe.random(position: e.position + 3.5);
      } else {
        return e;
      }
    }).toList();
  }

  bool birdHitPipe(width, height, bird) {
    for (int pipeNumber = 0; pipeNumber < state.length; pipeNumber++) {
      if (state[pipeNumber].position - 80 / width <= -0.45 &&
          state[pipeNumber].position + 80 / width >= -0.65 &&
          (bird.birdPosition >= 1 - (state[pipeNumber].height) / height ||
              bird.birdPosition <=
                  -1 + (height - state[pipeNumber].height - 200) / height)) {
        return true;
      }
    }
    return false;
  }
}

final pipeListProvider =
    StateNotifierProvider<PipeListNotifier, List<Pipe>>((ref) {
  return PipeListNotifier();
});