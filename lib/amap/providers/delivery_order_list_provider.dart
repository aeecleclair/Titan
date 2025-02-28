import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdminDeliveryOrderListNotifier extends MapNotifier<String, OrderReturn> {
  AdminDeliveryOrderListNotifier() : super();
}

final adminDeliveryOrderListProvider = StateNotifierProvider<
    AdminDeliveryOrderListNotifier,
    Map<String, AsyncValue<List<OrderReturn>>?>>((ref) {
  AdminDeliveryOrderListNotifier orderListNotifier =
      AdminDeliveryOrderListNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final deliveries = ref.watch(deliveryList);
    orderListNotifier.loadTList(deliveries.map((e) => e.id).toList());
  });
  return orderListNotifier;
});
