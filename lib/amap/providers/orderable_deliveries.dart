import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';

final orderableDeliveriesProvider = Provider((ref) {
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.when(
    data: (deliveryList) => deliveryList
        .where((delivery) => delivery.status == DeliveryStatus.orderable)
        .toList(),
    error: (error, stackTrace) => [],
    loading: () => [],
  );
});
