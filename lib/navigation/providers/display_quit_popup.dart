import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayQuitNotifier extends StateNotifier<bool> {
  DisplayQuitNotifier() : super(false);

  void setDisplay(bool newState) {
    state = newState;
  }
}

final displayQuitProvider = StateNotifierProvider<DisplayQuitNotifier, bool>((
  ref,
) {
  return DisplayQuitNotifier();
});
