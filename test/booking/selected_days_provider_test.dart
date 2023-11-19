// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';

void main() {
  group('SelectedDaysProvider', () {
    test('initial state should be a list of 7 false values', () {
      final provider = SelectedDaysProvider();
      expect(provider.state, [false, false, false, false, false, false, false]);
    });

    test('toggle should toggle the value at the given index', () {
      final provider = SelectedDaysProvider();
      provider.toggle(0);
      expect(provider.state[0], true);
      provider.toggle(0);
      expect(provider.state[0], false);
    });

    test('clear should set all values to false', () {
      final provider = SelectedDaysProvider();
      provider.toggle(0);
      provider.toggle(3);
      provider.clear();
      expect(provider.state, [false, false, false, false, false, false, false]);
    });

    test('setSelectedDays should set the state to the given list', () {
      final provider = SelectedDaysProvider();
      provider.setSelectedDays([true, false, true, false, true, false, true]);
      expect(provider.state, [true, false, true, false, true, false, true]);
    });
  });
}
