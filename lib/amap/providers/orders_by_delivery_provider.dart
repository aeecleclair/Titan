import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class OrderByDeliveryListNotifier extends ListNotifier<Order> {
  final OrderListRepository _orderListRepository = OrderListRepository();
  OrderByDeliveryListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _orderListRepository.setToken(token);
  }

  Future<AsyncValue<List<Order>>> loadDeliveryOrderList(
      String deliveryId) async {
    return await loadList(
        () async => _orderListRepository.getDeliveryOrderList(deliveryId));
  }
}

final orderByDeliveryListProvider =
    StateNotifierProvider<OrderByDeliveryListNotifier, AsyncValue<List<Order>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  return OrderByDeliveryListNotifier(token: token);
});
