import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

void main() {
  group('OrderNotifier', () {
    test('setOrder should update the state', () {
      final container = ProviderContainer();
      final orderNotifier = container.read(orderProvider.notifier);

      final order = OrderReturn.empty().copyWith(
        orderId: '123',
        productsdetail: [
          ProductQuantity.empty().copyWith(
            product: AppModulesAmapSchemasAmapProductComplete.empty().copyWith(
              name: 'Item 1',
              price: 10,
            ),
          ),
          ProductQuantity.empty().copyWith(
            product: AppModulesAmapSchemasAmapProductComplete.empty().copyWith(
              name: 'Item 2',
              price: 20,
            ),
          ),
        ],
      );

      orderNotifier.setOrder(order);

      expect(container.read(orderProvider), equals(order));
    });
  });
}
