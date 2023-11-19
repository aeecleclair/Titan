// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';

void main() {
  group('AmapPageNotifier', () {
    test('initial state is AmapPage.main', () {
      final container = ProviderContainer();
      final notifier = container.read(amapPageProvider.notifier);
      expect(notifier.state, AmapPage.main);
    });

    test('setAmapPage sets the correct state', () {
      final container = ProviderContainer();
      final notifier = container.read(amapPageProvider.notifier);
      notifier.setAmapPage(AmapPage.pres);
      expect(notifier.state, AmapPage.pres);
      notifier.setAmapPage(AmapPage.addProducts);
      expect(notifier.state, AmapPage.addProducts);
      notifier.setAmapPage(AmapPage.admin);
      expect(notifier.state, AmapPage.admin);
      notifier.setAmapPage(AmapPage.addEditProduct);
      expect(notifier.state, AmapPage.addEditProduct);
      notifier.setAmapPage(AmapPage.addEditDelivery);
      expect(notifier.state, AmapPage.addEditDelivery);
      notifier.setAmapPage(AmapPage.detailPage);
      expect(notifier.state, AmapPage.detailPage);
      notifier.setAmapPage(AmapPage.deliveryDetail);
      expect(notifier.state, AmapPage.deliveryDetail);
    });
  });
}
