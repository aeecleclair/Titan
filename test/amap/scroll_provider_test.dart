import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/scroll_provider.dart';

void main() {
  group('ScrollNotifier', () {
    test('initial state should be 0', () {
      final scrollNotifier = ScrollNotifier();
      expect(scrollNotifier.state, 0);
    });

    test('setScroll should update state', () {
      final scrollNotifier = ScrollNotifier();
      scrollNotifier.setScroll(50);
      expect(scrollNotifier.state, 50);
    });
  });

  group('scrollProvider', () {
    test('should provide ScrollNotifier', () {
      final container = ProviderContainer();
      final scrollNotifier = container.read(scrollProvider.notifier);
      expect(scrollNotifier, isA<ScrollNotifier>());
    });

    test('should provide initial state of 0', () {
      final container = ProviderContainer();
      final scrollState = container.read(scrollProvider);
      expect(scrollState, 0);
    });

    test('should update state when setScroll is called', () {
      final container = ProviderContainer();
      final scrollNotifier = container.read(scrollProvider.notifier);
      scrollNotifier.setScroll(50);
      final scrollState = container.read(scrollProvider);
      expect(scrollState, 50);
    });
  });
}
