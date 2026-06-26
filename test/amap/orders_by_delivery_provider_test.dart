import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/providers/orders_by_delivery_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockOrderListRepository extends Mock implements Openapi {}

void main() {
  group('Testing OrderByDeliveryListNotifier : loadDeliveryOrderList', () {
    late MockOrderListRepository mockOrderByDeliveryListRepository;
    late ProviderContainer container;
    late OrderByDeliveryListNotifier orderByDeliveryListNotifier;

    setUp(() async {
      mockOrderByDeliveryListRepository = MockOrderListRepository();
      container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWithValue(
            mockOrderByDeliveryListRepository,
          ),
        ],
      );
      orderByDeliveryListNotifier = container.read(
        orderByDeliveryListProvider.notifier,
      );
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('Should load delivery order list', () async {
      final orderByDeliveryList = [OrderReturn.empty().copyWith(orderId: "1")];
      when(
        () =>
            mockOrderByDeliveryListRepository.amapDeliveriesDeliveryIdOrdersGet(
              deliveryId: any(named: "deliveryId"),
            ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), orderByDeliveryList),
      );
      final deliveryOrderList = await orderByDeliveryListNotifier
          .loadDeliveryOrderList("");
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
