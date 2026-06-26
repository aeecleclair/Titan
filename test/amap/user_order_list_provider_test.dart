import 'dart:async';

import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/adapters/order_return.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockAmapUserRepository extends Mock implements Openapi {}

void main() {
  group('UserOrderListNotifier', () {
    late MockAmapUserRepository mockRepository;
    late ProviderContainer container;
    late UserOrderListNotifier notifier;

    const userId = '123';
    final orders = [
      OrderReturn(
        user: CoreUserSimple(
          id: '123',
          name: 'name',
          firstname: 'firstname',
          nickname: null,
          accountType: AccountType.$external,
          schoolId: 'schoolId',
        ),
        deliveryId: '1',
        deliveryName: 'Delivery',
        productsdetail: [],
        collectionSlot: AmapSlotType.midi,
        orderId: '1',
        amount: 10,
        orderingDate: DateTime.now(),
        deliveryDate: DateTime.now(),
      ),
      OrderReturn(
        user: CoreUserSimple(
          id: '123',
          name: 'name',
          firstname: 'firstname',
          nickname: null,
          accountType: AccountType.$external,
          schoolId: 'schoolId',
        ),
        deliveryId: '2',
        deliveryName: 'Delivery',
        productsdetail: [],
        collectionSlot: AmapSlotType.soir,
        orderId: '2',
        amount: 20,
        orderingDate: DateTime.now(),
        deliveryDate: DateTime.now(),
      ),
    ];

    final order = OrderReturn(
      user: CoreUserSimple(
        id: '123',
        name: 'name',
        firstname: 'firstname',
        nickname: null,
        accountType: AccountType.$external,
        schoolId: 'schoolId',
      ),
      deliveryId: '1',
      deliveryName: 'Delivery',
      productsdetail: [],
      collectionSlot: AmapSlotType.midi,
      orderId: '1',
      amount: 10,
      orderingDate: DateTime.now(),
      deliveryDate: DateTime.now(),
    );
    final orderToAdd = order.toOrderBase();

    setUp(() async {
      mockRepository = MockAmapUserRepository();
      container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWithValue(mockRepository),
          // Keep idProvider pending so build()'s whenData auto-load never
          // triggers a rebuild that would re-read state.
          idProvider.overrideWith((ref) => Completer<String>().future),
        ],
      );
      notifier = container.read(userOrderListProvider.notifier);
      await Future(() {});
      // build() returns the (still uninitialized) state when idProvider is
      // pending; seed an initial value so methods that don't set state
      // themselves (the *handle error* tests) have a valid state to read.
      notifier.state = const AsyncValue.data([]);
    });

    tearDown(() => container.dispose());

    test('loadOrderList should return the list of orders for a user', () async {
      when(
        () => mockRepository.amapUsersUserIdOrdersGet(userId: userId),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), orders),
      );

      final result = await notifier.loadOrderList(userId);

      expect(
        result.when(
          data: (orders) => orders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        orders,
      );
    });

    test('loadOrderList should handle error', () async {
      when(
        () => mockRepository.amapUsersUserIdOrdersGet(userId: userId),
      ).thenThrow(Exception('Error'));

      final result = await notifier.loadOrderList(userId);

      expect(result, isA<AsyncError>());
    });

    test('addOrder should add a new order to the list', () async {
      when(
        () => mockRepository.amapOrdersPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), order),
      );
      notifier.state = AsyncValue.data([]);

      final result = await notifier.addOrder(orderToAdd);

      expect(result, true);
      expect(
        notifier.state.when(
          data: (orders) => orders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        [order],
      );
    });

    test('addOrder should handle error', () async {
      when(
        () => mockRepository.amapOrdersPost(body: any(named: 'body')),
      ).thenThrow(Exception('Error'));

      final result = await notifier.addOrder(orderToAdd);

      expect(result, false);
    });

    test('updateOrder should update an existing order in the list', () async {
      final updatedOrder = order.copyWith(amount: 20);
      when(
        () => mockRepository.amapOrdersOrderIdPatch(
          orderId: any(named: 'orderId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), updatedOrder),
      );
      notifier.state = AsyncValue.data([order]);

      final result = await notifier.updateOrder(updatedOrder);

      expect(result, true);
      expect(
        notifier.state.when(
          data: (orders) => orders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        [updatedOrder],
      );
    });

    test('updateOrder should handle error', () async {
      when(
        () => mockRepository.amapOrdersOrderIdPatch(
          orderId: any(named: 'orderId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));

      final result = await notifier.updateOrder(order);

      expect(result, false);
    });

    test('deleteOrder should remove an order from the list', () async {
      when(
        () => mockRepository.amapOrdersOrderIdDelete(
          orderId: any(named: 'orderId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      notifier.state = AsyncValue.data([order]);

      final result = await notifier.deleteOrder(order);

      expect(result, true);
      expect(
        notifier.state.when(
          data: (orders) => orders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        [],
      );
    });

    test('deleteOrder should handle error', () async {
      when(
        () => mockRepository.amapOrdersOrderIdDelete(
          orderId: any(named: 'orderId'),
        ),
      ).thenThrow(Exception('Error'));

      final result = await notifier.deleteOrder(order);

      expect(result, false);
    });
  });
}
