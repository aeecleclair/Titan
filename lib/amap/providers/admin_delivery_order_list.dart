import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/toggle_map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:tuple/tuple.dart';

class AdminDeliveryOrderList extends ToggleMapNotifier<Delivery, Order> {
  AdminDeliveryOrderList({required String token}) : super(token: token);
}

final adminDeliveryOrderList = StateNotifierProvider<AdminDeliveryOrderList,
    AsyncValue<Map<Delivery, Tuple2<AsyncValue<List<Order>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  AdminDeliveryOrderList adminDeliveryOrderList =
      AdminDeliveryOrderList(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final deliveries = ref.watch(deliveryList);
    await adminDeliveryOrderList.loadTList(deliveries);
  });
  return adminDeliveryOrderList;
});
