import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final selectedDaysProvider =
    StateNotifierProvider<SelectedDaysProvider, List<WeekDays>>((ref) {
      return SelectedDaysProvider();
    });

class SelectedDaysProvider extends StateNotifier<List<WeekDays>> {
  SelectedDaysProvider() : super(List.empty());

  void toggle(WeekDays day) {
    var copy = state.toList();
    if (copy.contains(day)) {
      copy.remove(day);
    } else {
      copy.add(day);
    }
    state = copy;
  }

  void clear() {
    state = List.empty();
  }

  void setSelectedDays(List<WeekDays> days) {
    state = days;
  }
}
