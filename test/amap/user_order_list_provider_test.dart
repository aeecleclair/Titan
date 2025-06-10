import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';

import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/repositories/amap_user_repository.dart';
import 'package:titan/amap/repositories/order_list_repository.dart';

class MockAmapUserRepository extends Mock implements AmapUserRepository {}

class MockOrderListRepository extends Mock implements OrderListRepository {}

void main() {
  group('UserOrderListNotifier', () {
    late AmapUserRepository userRepository;
    late OrderListRepository orderListRepository;
    late UserOrderListNotifier notifier;

    setUp(() {
      userRepository = MockAmapUserRepository();
      orderListRepository = MockOrderListRepository();
      notifier = UserOrderListNotifier(
        userRepository: userRepository,
        orderListRepository: orderListRepository,
      );
    });

    test('loadOrderList', () async {
      const userId = '123';
      final orders = [
        Order.empty().copyWith(id: '1'),
        Order.empty().copyWith(id: '2'),
      ];
      when(
        () => userRepository.getOrderList(userId),
      ).thenAnswer((_) async => orders);

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

    test('loadDeliveryOrderList should return a list of orders', () async {
      const deliveryId = '123';
      final orders = [
        Order.empty().copyWith(id: '1'),
        Order.empty().copyWith(id: '2'),
      ];
      when(
        () => orderListRepository.getDeliveryOrderList(deliveryId),
      ).thenAnswer((_) async => orders);

      final result = await notifier.loadDeliveryOrderList(deliveryId);

      expect(
        result.when(
          data: (orders) => orders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        orders,
      );
    });

    test('addOrder', () async {
      final order = Order.empty().copyWith(id: '1');
      notifier.state = AsyncValue.data([order]);
      when(
        () => orderListRepository.createOrder(order),
      ).thenAnswer((_) async => order);

      final result = await notifier.addOrder(order);

      expect(result, isTrue);
    });

    test('updateOrder', () async {
      final order = Order.empty().copyWith(id: '1');
      notifier.state = AsyncValue.data([order]);
      when(
        () => orderListRepository.updateOrder(order),
      ).thenAnswer((_) async => true);

      final result = await notifier.updateOrder(order);

      expect(result, isTrue);
    });

    test('deleteOrder', () async {
      final order = Order.empty().copyWith(id: '1');
      notifier.state = AsyncValue.data([order]);
      when(
        () => orderListRepository.deleteOrder(order.id),
      ).thenAnswer((_) async => true);

      final result = await notifier.deleteOrder(order);

      expect(result, isTrue);
    });
  });
}
