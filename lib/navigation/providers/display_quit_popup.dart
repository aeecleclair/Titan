import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayQuitNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setDisplay(bool newState) {
    state = newState;
  }
}

final displayQuitProvider = NotifierProvider<DisplayQuitNotifier, bool>(
  DisplayQuitNotifier.new,
);
