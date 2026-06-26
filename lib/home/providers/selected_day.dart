import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDay extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setSelected(int event) {
    state = event;
  }
}

final selectedDayProvider = NotifierProvider<SelectedDay, int>(SelectedDay.new);
