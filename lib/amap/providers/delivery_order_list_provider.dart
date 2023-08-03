import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserOrderListNotifier extends MapNotifier<String, Order> {
  UserOrderListNotifier() : super();
}

final adminDeliveryOrderListProvider = StateNotifierProvider<
    UserOrderListNotifier,
    AsyncValue<Map<String, AsyncValue<List<Order>>>>>((ref) {
  UserOrderListNotifier orderListNotifier = UserOrderListNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final deliveries = ref.watch(deliveryList);
    orderListNotifier.loadTList(deliveries.map((e) => e.id).toList());
  });
  return orderListNotifier;
});
