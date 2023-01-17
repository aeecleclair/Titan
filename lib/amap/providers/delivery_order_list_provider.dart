import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserOrderListNotifier extends MapNotifier<Delivery, Order> {
  UserOrderListNotifier({required String token}) : super(token: token);
}

final adminDeliveryOrderListProvider = StateNotifierProvider<
    UserOrderListNotifier,
    AsyncValue<Map<Delivery, AsyncValue<List<Order>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  UserOrderListNotifier orderListNotifier = UserOrderListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final deliveries = ref.watch(deliveryList);
    orderListNotifier.loadTList(deliveries);
  });
  return orderListNotifier;
});
