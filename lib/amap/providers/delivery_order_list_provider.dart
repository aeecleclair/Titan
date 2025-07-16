import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SuperAdminDeliveryOrderListNotifier extends MapNotifier<String, Order> {
  SuperAdminDeliveryOrderListNotifier() : super();
}

final adminDeliveryOrderListProvider =
    StateNotifierProvider<
      SuperAdminDeliveryOrderListNotifier,
      Map<String, AsyncValue<List<Order>>?>
    >((ref) {
      SuperAdminDeliveryOrderListNotifier orderListNotifier =
          SuperAdminDeliveryOrderListNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final deliveries = ref.watch(deliveryList);
        orderListNotifier.loadTList(deliveries.map((e) => e.id).toList());
      });
      return orderListNotifier;
    });
