import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setState(bool newState) {
    state = newState;
  }
}

final gameStateProvider = NotifierProvider<GameNotifier, bool>(
  GameNotifier.new,
);
