import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/amap/providers/searching_amap_user_provider.dart';

void main() {
  group('SearchingAmapUserNotifier', () {
    test('SearchingAmapUserNotifier sets state correctly', () {
      final notifier = SearchingAmapUserNotifier();

      expect(notifier.state, true);

      notifier.setProduct(false);

      expect(notifier.state, false);
    });

    test('searchingAmapUserProvider returns correct value', () {
      final container = ProviderContainer();

      expect(container.read(searchingAmapUserProvider), true);

      container.read(searchingAmapUserProvider.notifier).setProduct(false);

      expect(container.read(searchingAmapUserProvider), false);
    });
  });
}
