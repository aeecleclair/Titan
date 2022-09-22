import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:tuple/tuple.dart';


class AdminDeliveryOrderList extends MapNotifier<Delivery, Order> {
  AdminDeliveryOrderList({required String token}) : super(token: token);
}

final adminDeliveryOrderList = StateNotifierProvider<AdminDeliveryOrderList,
    AsyncValue<Map<Delivery, Tuple2<AsyncValue<List<Order>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final deliveries = ref.watch(deliveryList);
  AdminDeliveryOrderList adminDeliveryOrderList =
      AdminDeliveryOrderList(token: token);
  adminDeliveryOrderList.loadTList(deliveries);
  return adminDeliveryOrderList;
});