import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SelectedDaysProvider extends Notifier<List<WeekDays>> {
  @override
  List<WeekDays> build() {
    return List.empty();
  }

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

final selectedDaysProvider =
    NotifierProvider<SelectedDaysProvider, List<WeekDays>>(
      SelectedDaysProvider.new,
    );
