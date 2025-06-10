import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/repositories/delivery_list_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDeliveryListRepository extends Mock
    implements DeliveryListRepository {}

void main() {
  group('DeliveryListNotifier', () {
    test(
      'loadDeliveriesList should return the list of deliveries from the repository',
      () async {
        // Arrange
        final mockRepository = MockDeliveryListRepository();
        final deliveries = [Delivery.empty(), Delivery.empty()];
        when(
          () => mockRepository.getDeliveryList(),
        ).thenAnswer((_) async => deliveries);
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: mockRepository,
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
      final mockRepository = MockDeliveryListRepository();
      final delivery = Delivery.empty();
      final deliveries = [Delivery.empty(), Delivery.empty()];
      when(
        () => mockRepository.createDelivery(delivery),
      ).thenAnswer((_) async => delivery);
      final notifier = DeliveryListNotifier(
        deliveriesListRepository: mockRepository,
      );
      notifier.state = AsyncValue.data(deliveries);

      // Act
      final result = await notifier.addDelivery(delivery);

      // Assert
      expect(result, true);
    });

    test(
      'updateDelivery should update an existing delivery in the list',
      () async {
        // Arrange
        final mockRepository = MockDeliveryListRepository();
        final delivery = Delivery.empty();
        final updatedDelivery = delivery.copyWith(expanded: true);
        final deliveries = [delivery];
        when(
          () => mockRepository.updateDelivery(updatedDelivery),
        ).thenAnswer((_) async => true);
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: mockRepository,
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
        final mockRepository = MockDeliveryListRepository();
        final delivery = Delivery.empty();
        when(
          () => mockRepository.openDelivery(delivery),
        ).thenAnswer((_) async => true);
        final deliveries = [delivery];
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: mockRepository,
        );
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
          DeliveryStatus.available,
        );
      },
    );

    test(
      'lockDelivery should update the status of a delivery to locked',
      () async {
        // Arrange
        final mockRepository = MockDeliveryListRepository();
        final delivery = Delivery.empty();
        final deliveries = [delivery];
        when(
          () => mockRepository.lockDelivery(delivery),
        ).thenAnswer((_) async => true);
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: mockRepository,
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
          DeliveryStatus.locked,
        );
      },
    );

    test(
      'deliverDelivery should update the status of a delivery to delivered',
      () async {
        // Arrange
        final mockRepository = MockDeliveryListRepository();
        final delivery = Delivery.empty();
        final deliveries = [delivery];
        when(
          () => mockRepository.deliverDelivery(delivery),
        ).thenAnswer((_) async => true);
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: mockRepository,
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
          DeliveryStatus.delivered,
        );
      },
    );

    test('archiveDelivery should remove a delivery from the list', () async {
      // Arrange
      final mockRepository = MockDeliveryListRepository();
      final delivery = Delivery.empty();
      final deliveries = [delivery];
      when(
        () => mockRepository.archiveDelivery(delivery.id),
      ).thenAnswer((_) async => true);
      final notifier = DeliveryListNotifier(
        deliveriesListRepository: mockRepository,
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
      final mockRepository = MockDeliveryListRepository();
      final delivery = Delivery.empty().copyWith(id: '1');
      final deliveries = [delivery];
      when(
        () => mockRepository.deleteDelivery(delivery.id),
      ).thenAnswer((_) async => true);
      final notifier = DeliveryListNotifier(
        deliveriesListRepository: mockRepository,
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

    test(
      'toggleExpanded should toggle the expanded property of a delivery',
      () {
        // Arrange
        final delivery1 = Delivery.empty().copyWith(id: '1');
        final delivery2 = Delivery.empty().copyWith(id: '2');
        final deliveries = [delivery1, delivery2];
        final notifier = DeliveryListNotifier(
          deliveriesListRepository: MockDeliveryListRepository(),
        );

        // Act/Assert (loading state)
        notifier.toggleExpanded('1');
        expect(
          notifier.state,
          const AsyncValue<List<Delivery>>.error(
            "Cannot toggle expanded while loading",
            StackTrace.empty,
          ),
        );

        // Act/Assert (error state)
        notifier.state = const AsyncValue<List<Delivery>>.error(
          'Error',
          StackTrace.empty,
        );
        notifier.toggleExpanded('1');
        expect(
          notifier.state,
          const AsyncValue<List<Delivery>>.error('Error', StackTrace.empty),
        );

        // Act/Assert (data state)
        notifier.state = AsyncValue.data(deliveries);
        notifier.toggleExpanded('1');
        expect(
          notifier.state
              .when(
                data: (data) => data,
                error: (e, s) => [],
                loading: () => [],
              )
              .first
              .expanded,
          isTrue,
        );
      },
    );
    test('copy should return a copy of the list of deliveries', () async {
      // Arrange
      final delivery1 = Delivery.empty().copyWith(id: '1');
      final delivery2 = Delivery.empty().copyWith(id: '2');
      final deliveries = [delivery1, delivery2];
      final notifier = DeliveryListNotifier(
        deliveriesListRepository: MockDeliveryListRepository(),
      );

      // Act/Assert (loading state)
      final result1 = await notifier.copy();
      expect(result1, []);

      // Act/Assert (error state)
      notifier.state = const AsyncValue<List<Delivery>>.error(
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
