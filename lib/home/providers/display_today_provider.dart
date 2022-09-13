import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayTodayProvider =
    StateNotifierProvider<DisplayTodayNotifier, bool>((ref) {
  return DisplayTodayNotifier();
});

class DisplayTodayNotifier extends StateNotifier<bool> {
  DisplayTodayNotifier() : super(false);

  void setDisplay(bool i) {
    state = i;
  }
}
