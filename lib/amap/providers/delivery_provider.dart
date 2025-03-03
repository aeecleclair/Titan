import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

final deliveryProvider = Provider<DeliveryReturn>((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.maybeWhen(
    data: (deliveryList) => deliveryList.firstWhere(
      (delivery) => delivery.id == deliveryId,
      orElse: () => EmptyModels.empty<DeliveryReturn>(),
    ),
    orElse: () => EmptyModels.empty<DeliveryReturn>(),
  );
});
