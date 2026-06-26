import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/providers/start_provider.dart';

void main() {
  group('StartNotifier', () {
    late StartNotifier startNotifier;

    setUp(() {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      startNotifier = container.read(startProvider.notifier);
    });

    test('initial state is empty string', () {
      expect(startNotifier.state, '');
    });

    test('setStart updates state', () {
      startNotifier.setStart('New York');
      expect(startNotifier.state, 'New York');
    });
  });

  group('startProvider', () {
    test('provides a StartNotifier', () {
      final container = ProviderContainer();
      final start = container.read(startProvider);
      expect(start, isA());
    });
  });
}
