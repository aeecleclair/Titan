import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/providers/initial_date_provider.dart';

void main() {
  group('InitialDateNotifier', () {
    test('initial value is DateTime.now()', () {
      final provider = InitialDateNotifier();
      expect(provider.state, isA<DateTime>());
    });

    test('setDate() updates the state', () {
      final provider = InitialDateNotifier();
      final newDate = DateTime(2022, 1, 1);
      provider.setDate(newDate);
      expect(provider.state, newDate);
    });
  });

  group('initialDateProvider', () {
    test('initial value is DateTime.now()', () {
      final container = ProviderContainer();
      final initialValue = container.read(initialDateProvider);
      expect(initialValue, isA<DateTime>());
    });

    test('setDate() updates the state', () {
      final container = ProviderContainer();
      final newDate = DateTime(2022, 1, 1);
      container.read(initialDateProvider.notifier).setDate(newDate);
      final updatedValue = container.read(initialDateProvider);
      expect(updatedValue, newDate);
    });
  });
}
