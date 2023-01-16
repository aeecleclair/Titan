import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';

final deliveryIdProvider =
    StateNotifierProvider<DeliveryIdProvider, String>((ref) {
  final deliveries = ref.watch(deliveryList);
  if (deliveries.isEmpty) {
    return DeliveryIdProvider("");
  }
  final orderableDeliveries = deliveries
      .where((element) => element.status == DeliveryStatus.orderable)
      .toList();
      if (orderableDeliveries.isEmpty) {
        return DeliveryIdProvider("");
      }
  return DeliveryIdProvider(orderableDeliveries.first.id);
});

class DeliveryIdProvider extends StateNotifier<String> {
  DeliveryIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}
