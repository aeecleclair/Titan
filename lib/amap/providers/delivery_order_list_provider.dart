import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdminDeliveryOrderListNotifier extends MapNotifier<String, Order> {
  AdminDeliveryOrderListNotifier() : super();
}

final adminDeliveryOrderListProvider =
    StateNotifierProvider<
      AdminDeliveryOrderListNotifier,
      Map<String, AsyncValue<List<Order>>?>
    >((ref) {
      AdminDeliveryOrderListNotifier orderListNotifier =
          AdminDeliveryOrderListNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final deliveries = ref.watch(deliveryList);
        orderListNotifier.loadTList(deliveries.map((e) => e.id).toList());
      });
      return orderListNotifier;
    });
