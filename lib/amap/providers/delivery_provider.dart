import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';

final deliveryProvider = Provider<Delivery>((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.maybeWhen(
    data: (deliveryList) => deliveryList.firstWhere(
      (delivery) => delivery.id == deliveryId,
      orElse: () => Delivery.empty(),
    ),
    orElse: () => Delivery.empty(),
  );
});
