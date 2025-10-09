import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDaysProvider =
    StateNotifierProvider<SelectedDaysProvider, List<bool>>((ref) {
      return SelectedDaysProvider();
    });

class SelectedDaysProvider extends StateNotifier<List<bool>> {
  SelectedDaysProvider() : super(List.generate(7, (index) => false));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => false);
  }
}
