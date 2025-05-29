import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlreadyDisplayedNotifier extends StateNotifier<bool> {
  AlreadyDisplayedNotifier() : super(false);

  void setAlreadyDisplayed() {
    state = true;
  }
}

final alreadyDisplayedProvider =
    StateNotifierProvider<AlreadyDisplayedNotifier, bool>((ref) {
      return AlreadyDisplayedNotifier();
    });
