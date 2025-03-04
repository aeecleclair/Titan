import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockDeliveryListRepository extends Mock implements Openapi {}

void main() {
  group('DeliveryListNotifier', () {
    final delivery = DeliveryReturn(
      id: '1',
      deliveryDate: DateTime.now(),
      status: DeliveryStatusType.orderable,
    );

    final deliveries = [
      DeliveryReturn(
        id: '2',
        deliveryDate: DateTime.now(),
        status: DeliveryStatusType.orderable,
      ),
      DeliveryReturn(
        id: '3',
        deliveryDate: DateTime.now(),
        status: DeliveryStatusType.locked,
      ),
    ];

    test(
        'loadDeliveriesList should return the list of deliveries from the repository',
        () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      when(() => mockRepository.amapDeliveriesGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), deliveries),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);

      // Act
      final result = await notifier.loadDeliveriesList();

      // Assert
      expect(
        result.when(
          data: (data) => data,
          error: (e, s) => [],
          loading: () => [],
        ),
        deliveries,
      );
    });

    test('addDelivery should add a new delivery to the list', () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final deliveryBase = DeliveryBase(deliveryDate: DateTime.now());
      when(() => mockRepository.amapDeliveriesPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), delivery),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.addDelivery(deliveryBase);

      // Assert
      expect(result, true);
    });

    test('updateDelivery should update an existing delivery in the list',
        () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final updatedDelivery =
          delivery.copyWith(status: DeliveryStatusType.locked);
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdPatch(
          deliveryId: any(named: 'deliveryId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), updatedDelivery),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.updateDelivery(updatedDelivery);

      // Assert
      expect(result, true);
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => [],
          loading: () => [],
        ),
        [updatedDelivery],
      );
    });

    test('openDelivery should update the status of a delivery to orderable',
        () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      when(
        () => mockRepository.amapDeliveriesDeliveryIdOpenorderingPost(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          delivery.copyWith(status: DeliveryStatusType.orderable),
        ),
      );
      final deliveries = [delivery];
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.openDelivery(delivery);

      // Assert
      expect(result, true);
      expect(
        notifier.state
            .when(
              data: (data) => data,
              error: (e, s) => [],
              loading: () => [],
            )
            .first
            .status,
        DeliveryStatusType.orderable,
      );
    });

    test('lockDelivery should update the status of a delivery to locked',
        () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdLockPost(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          delivery.copyWith(status: DeliveryStatusType.locked),
        ),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.lockDelivery(delivery);

      // Assert
      expect(result, true);
      expect(
        notifier.state
            .when(
              data: (data) => data,
              error: (e, s) => [],
              loading: () => [],
            )
            .first
            .status,
        DeliveryStatusType.locked,
      );
    });

    test('deliverDelivery should update the status of a delivery to delivered',
        () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdDeliveredPost(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          delivery.copyWith(status: DeliveryStatusType.delivered),
        ),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.deliverDelivery(delivery);

      // Assert
      expect(result, true);
      expect(
        notifier.state
            .when(
              data: (data) => data,
              error: (e, s) => [],
              loading: () => [],
            )
            .first
            .status,
        DeliveryStatusType.delivered,
      );
    });

    test('archiveDelivery should remove a delivery from the list', () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdArchivePost(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.archiveDelivery(delivery);

      // Assert
      expect(result, true);
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => [],
          loading: () => [],
        ),
        [],
      );
    });

    test('deleteDelivery should remove a delivery from the list', () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdDelete(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final notifier =
          DeliveryListNotifier(deliveriesListRepository: mockRepository);
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.deleteDelivery(delivery.id);

      // Assert
      expect(result, true);
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        [],
      );
    });

    test('copy should return a copy of the list of deliveries', () async {
      // Arrange
      final notifier = DeliveryListNotifier(
        deliveriesListRepository: MockDeliveryListRepository(),
      );

      // Act/Assert (loading state)
      final result1 = await notifier.copy();
      expect(result1, []);

      // Act/Assert (error state)
      notifier.state = const AsyncValue<List<DeliveryReturn>>.error(
        'Error',
        StackTrace.empty,
      );
      final result2 = await notifier.copy();
      expect(result2, []);

      // Act/Assert (data state)
      notifier.state = AsyncValue.data(deliveries);
      final result3 = await notifier.copy();
      expect(result3, deliveries);
      expect(result3, isNot(same(deliveries)));
    });
  });
}
