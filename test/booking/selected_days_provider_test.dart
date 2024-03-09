import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  group('SelectedDaysProvider', () {
    test('initial state should be an empty list', () {
      final provider = SelectedDaysProvider();
      expect(provider.state, List<WeekDays>.empty());
    });

    test('toggle should add the week day to the list', () {
      final provider = SelectedDaysProvider();
      provider.toggle(WeekDays.monday);
      expect(provider.state.contains(WeekDays.monday), true);
      provider.toggle(WeekDays.monday);
      expect(provider.state.contains(WeekDays.monday), false);
    });

    test('clear should remove all values', () {
      final provider = SelectedDaysProvider();
      provider.toggle(WeekDays.monday);
      provider.toggle(WeekDays.thursday);
      provider.clear();
      expect(provider.state, List<WeekDays>.empty());
    });

    test('setSelectedDays should set the state to the given list', () {
      final provider = SelectedDaysProvider();
      provider.setSelectedDays([WeekDays.monday, WeekDays.wednesday]);
      expect(provider.state, [WeekDays.monday, WeekDays.wednesday]);
    });
  });
}
