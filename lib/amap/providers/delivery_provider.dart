import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';

final deliveryProvider = Provider((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.when(
    data: (deliveryList) => deliveryList.firstWhere(
        (delivery) => delivery.id == deliveryId,
        orElse: () => Delivery.empty()),
    error: (error, stackTrace) => Delivery.empty(),
    loading: () => Delivery.empty(),
  );
});
