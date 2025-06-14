import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/orders_by_delivery_provider.dart';
import 'package:titan/amap/repositories/order_list_repository.dart';

class MockOrderListRepository extends Mock implements OrderListRepository {}

void main() {
  group('Testing OrderByDeliveryListNotifier : loadDeliveryOrderList', () {
    test('Should load delivery order list', () async {
      final mockOrderByDeliveryListRepository = MockOrderListRepository();
      final orderByDeliveryList = [Order.empty().copyWith(id: "1")];
      when(
        () => mockOrderByDeliveryListRepository.getDeliveryOrderList(""),
      ).thenAnswer((_) async => orderByDeliveryList);
      final orderByDeliveryListNotifier = OrderByDeliveryListNotifier(
        orderListRepository: mockOrderByDeliveryListRepository,
      );
      final deliveryOrderList = await orderByDeliveryListNotifier
          .loadDeliveryOrderList("");
      expect(deliveryOrderList, isA<AsyncData<List<Order>>>());
      expect(
        deliveryOrderList.when(
          data: (data) => data.length,
          loading: () => 0,
          error: (error, stackTrace) => 0,
        ),
        1,
      );
    });
  });
}
