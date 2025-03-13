import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/providers/orders_by_delivery_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class MockOrderListRepository extends Mock implements Openapi {}

void main() {
  group('Testing OrderByDeliveryListNotifier : loadDeliveryOrderList', () {
    test('Should load delivery order list', () async {
      final mockOrderByDeliveryListRepository = MockOrderListRepository();
      final orderByDeliveryList = [
        EmptyModels.empty<OrderReturn>().copyWith(orderId: "1"),
      ];
      when(
        () =>
            mockOrderByDeliveryListRepository.amapDeliveriesDeliveryIdOrdersGet(
          deliveryId: any(named: "deliveryId"),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), orderByDeliveryList),
      );
      final orderByDeliveryListNotifier = OrderByDeliveryListNotifier(
        orderListRepository: mockOrderByDeliveryListRepository,
      );
      final deliveryOrderList =
          await orderByDeliveryListNotifier.loadDeliveryOrderList("");
      expect(deliveryOrderList, isA<AsyncData<List<OrderReturn>>>());
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
