import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';

final availableDeliveriesProvider = Provider((ref) {
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.maybeWhen(
    data: (deliveryList) => deliveryList
        .where((delivery) => delivery.status == DeliveryStatus.available)
        .toList(),
    orElse: () => [],
  );
});
