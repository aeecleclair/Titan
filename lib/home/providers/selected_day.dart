import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDay extends StateNotifier<int> {
  SelectedDay() : super(0);

  void setSelected(int event) {
    state = event;
  }
}

final selectedDayProvider = StateNotifierProvider<SelectedDay, int>((ref) {
  return SelectedDay();
});