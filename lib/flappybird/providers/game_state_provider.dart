import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStateNotifier extends StateNotifier<bool> {
  GameStateNotifier() : super(false);

  void setState(bool newState) {
    state = newState;
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, bool>((ref) {
  return GameStateNotifier();
});
