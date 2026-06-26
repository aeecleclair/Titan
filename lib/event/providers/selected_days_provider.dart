import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDaysProvider = NotifierProvider<SelectedDaysProvider, List<bool>>(
  () => SelectedDaysProvider(),
);

class SelectedDaysProvider extends Notifier<List<bool>> {
  @override
  List<bool> build() {
    return List.generate(7, (index) => false);
  }

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => false);
  }
}
