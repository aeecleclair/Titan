import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('OrderNotifier', () {
    test('setOrder should update the state', () {
      final container = ProviderContainer();
      final orderNotifier = container.read(orderProvider.notifier);

      final order = OrderReturn.fromJson({}).copyWith(
        orderId: '123',
        productsdetail: [
          ProductQuantity.fromJson({}).copyWith(
            product: AppModulesAmapSchemasAmapProductComplete.fromJson({})
                .copyWith(name: 'Item 1', price: 10),
          ),
          ProductQuantity.fromJson({}).copyWith(
            product: AppModulesAmapSchemasAmapProductComplete.fromJson({})
                .copyWith(name: 'Item 2', price: 20),
          ),
        ],
      );

      orderNotifier.setOrder(order);

      expect(container.read(orderProvider), equals(order));
    });
  });
}
