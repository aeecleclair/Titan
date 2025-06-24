import 'package:flutter_test/flutter_test.dart';
import 'package:titan/cinema/providers/scroll_provider.dart';

void main() {
  group('ScrollNotifier', () {
    test('setScroll should update state', () {
      final scrollNotifier = ScrollNotifier(2.0);
      scrollNotifier.setScroll(100.0);
      expect(scrollNotifier.state, 100.0);
    });

    test('reset should set state to startScroll', () {
      final scrollNotifier = ScrollNotifier(2.0);
      scrollNotifier.setScroll(100.0);
      scrollNotifier.reset();
      expect(scrollNotifier.state, 2.0);
    });
  });
}
