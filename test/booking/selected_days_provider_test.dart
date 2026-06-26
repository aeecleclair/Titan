import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/booking/providers/selected_days_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  group('SelectedDaysProvider', () {
    test('initial state should be an empty list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      expect(provider.state, []);
    });

    test('toggle should add the week day to the list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      provider.toggle(WeekDays.monday);
      expect(provider.state.contains(WeekDays.monday), true);
      provider.toggle(WeekDays.monday);
      expect(provider.state.contains(WeekDays.monday), false);
    });

    test('clear should remove all values', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      provider.toggle(WeekDays.monday);
      provider.toggle(WeekDays.thursday);
      provider.clear();
      expect(provider.state, []);
    });

    test('setSelectedDays should set the state to the given list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      provider.setSelectedDays([WeekDays.monday, WeekDays.wednesday]);
      expect(provider.state, [WeekDays.monday, WeekDays.wednesday]);
    });
  });
}
