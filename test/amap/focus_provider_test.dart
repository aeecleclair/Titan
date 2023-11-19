// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/focus_provider.dart';

void main() {
  group('FocusNotifier', () {
    late FocusNotifier focusNotifier;

    setUp(() {
      focusNotifier = FocusNotifier();
    });

    test('initial state should be false', () {
      expect(focusNotifier.state, false);
    });

    test('setFocus should update state', () {
      focusNotifier.setFocus(true);
      expect(focusNotifier.state, true);

      focusNotifier.setFocus(false);
      expect(focusNotifier.state, false);
    });
  });

  group('focusProvider', () {
    test('should provide a FocusNotifier', () {
      final container = ProviderContainer();
      final focusNotifier = container.read(focusProvider.notifier);

      expect(focusNotifier, isA<FocusNotifier>());
    });

    test('should provide the initial state', () {
      final container = ProviderContainer();
      final focusState = container.read(focusProvider);

      expect(focusState, false);
    });
  });
}
