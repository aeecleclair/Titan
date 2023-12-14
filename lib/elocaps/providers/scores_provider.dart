import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoresNotifier extends StateNotifier<List<int>> {
  ScoresNotifier() : super([0, 0]);

  void oneWin() {
    state = [1, -1];
  }

  void twoWin() {
    state = [-1, 1];
  }

  void equality() {
    state = [0, 0];
  }
}

final scoresProvider = StateNotifierProvider<ScoresNotifier, List<int>>((ref) {
  return ScoresNotifier();
});
