import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/providers/display_results.dart';

void main() {
  group('DisplayResult', () {
    test('initial state should be false', () {
      final container = ProviderContainer();
      final displayResultNotifier = container.read(displayResult.notifier);

      expect(displayResultNotifier.state, false);
    });

    test('setId should update state', () {
      final container = ProviderContainer();
      final displayResultNotifier = container.read(displayResult.notifier);

      displayResultNotifier.setId(true);

      expect(displayResultNotifier.state, true);
    });
  });
}
