import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

final deliveryProvider = Provider<DeliveryReturn>((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.maybeWhen(
    data: (deliveryList) => deliveryList.firstWhere(
      (delivery) => delivery.id == deliveryId,
      orElse: () => DeliveryReturn.empty(),
    ),
    orElse: () => DeliveryReturn.empty(),
  );
});
