import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AdminDeliveryOrderListNotifier extends MapNotifier<String, OrderReturn> {
  @override
  Map<String, AsyncValue<List<OrderReturn>>?> build() {
    final deliveries = ref.watch(deliveryList);
    loadTList(deliveries.map((e) => e.id).toList());
    return state;
  }
}

final adminDeliveryOrderListProvider =
    NotifierProvider<
      AdminDeliveryOrderListNotifier,
      Map<String, AsyncValue<List<OrderReturn>>?>
    >(() => AdminDeliveryOrderListNotifier());
