import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/amap/providers/selected_category_provider.dart';

void main() {
  group('SelectedCategoryNotifier', () {
    test('initial state should be the provided text', () {
      final container = ProviderContainer();
      final provider = container.read(
        selectedCategoryProvider('initial text').notifier,
      );
      expect(provider.state, 'initial text');
    });

    test('setText should update the state', () {
      final container = ProviderContainer();
      final provider = container.read(
        selectedCategoryProvider('initial text').notifier,
      );
      provider.setText('new text');
      expect(provider.state, 'new text');
    });
  });
}
