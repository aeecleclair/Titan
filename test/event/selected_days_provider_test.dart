import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/event/providers/selected_days_provider.dart';

void main() {
  group('SelectedDaysProvider', () {
    test('initial state should be a list of 7 false values', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      expect(provider.state, [false, false, false, false, false, false, false]);
    });

    test('toggle should toggle the value at the given index', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      provider.toggle(0);
      expect(provider.state[0], true);
      provider.toggle(0);
      expect(provider.state[0], false);
    });

    test('clear should set all values to false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = container.read(selectedDaysProvider.notifier);
      provider.toggle(0);
      provider.toggle(3);
      provider.clear();
      expect(provider.state, [false, false, false, false, false, false, false]);
    });
  });
}
