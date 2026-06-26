import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockDeliveryListRepository extends Mock implements Openapi {}

void main() {
  group('DeliveryListNotifier', () {
    late MockDeliveryListRepository mockRepository;
    late ProviderContainer container;
    late DeliveryListNotifier notifier;

    final delivery = DeliveryReturn(
      name: 'Delivery 1',
      id: '1',
      deliveryDate: DateTime.now(),
      status: DeliveryStatusType.orderable,
    );

    final deliveries = [
      DeliveryReturn(
        name: 'Delivery 2',
        id: '2',
        deliveryDate: DateTime.now(),
        status: DeliveryStatusType.orderable,
      ),
      DeliveryReturn(
        name: 'Delivery 3',
        id: '3',
        deliveryDate: DateTime.now(),
        status: DeliveryStatusType.locked,
      ),
    ];

    setUp(() async {
      mockRepository = MockDeliveryListRepository();
      when(() => mockRepository.amapDeliveriesGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), <DeliveryReturn>[]),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      notifier = container.read(deliveryListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test(
      'loadDeliveriesList should return the list of deliveries from the repository',
      () async {
        // Arrange
        when(() => mockRepository.amapDeliveriesGet()).thenAnswer(
          (_) async => chopper.Response(http.Response('[]', 200), deliveries),
        );

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
      },
    );

    test('addDelivery should add a new delivery to the list', () async {
      // Arrange
      final deliveryBase = DeliveryBase(
        name: 'Delivery',
        deliveryDate: DateTime.now(),
      );
      when(
        () => mockRepository.amapDeliveriesPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), delivery),
      );
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.addDelivery(deliveryBase);

      // Assert
      expect(result, true);
    });

    test(
      'updateDelivery should update an existing delivery in the list',
      () async {
        // Arrange
        final updatedDelivery = delivery.copyWith(
          status: DeliveryStatusType.locked,
        );
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
      },
    );

    test(
      'openDelivery should update the status of a delivery to orderable',
      () async {
        // Arrange
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
      },
    );

    test(
      'lockDelivery should update the status of a delivery to locked',
      () async {
        // Arrange
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
      },
    );

    test(
      'deliverDelivery should update the status of a delivery to delivered',
      () async {
        // Arrange
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
      },
    );

    test('archiveDelivery should remove a delivery from the list', () async {
      // Arrange
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdArchivePost(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
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
      final deliveries = [delivery];
      when(
        () => mockRepository.amapDeliveriesDeliveryIdDelete(
          deliveryId: any(named: 'deliveryId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.deleteDelivery(delivery);

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
      // Act/Assert (loading state)
      notifier.state = const AsyncValue<List<DeliveryReturn>>.loading();
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
