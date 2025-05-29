import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class OrderByDeliveryListNotifier extends ListNotifier<Order> {
  final OrderListRepository orderListRepository;
  OrderByDeliveryListNotifier({required this.orderListRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Order>>> loadDeliveryOrderList(
    String deliveryId,
  ) async {
    return await loadList(
      () async => orderListRepository.getDeliveryOrderList(deliveryId),
    );
  }
}

final orderByDeliveryListProvider =
    StateNotifierProvider<OrderByDeliveryListNotifier, AsyncValue<List<Order>>>(
      (ref) {
        final orderListRepository = ref.watch(orderListRepositoryProvider);
        return OrderByDeliveryListNotifier(
          orderListRepository: orderListRepository,
        );
      },
    );
