import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

final availableDeliveriesProvider = Provider((ref) {
  final deliveryList = ref.watch(deliveryListProvider);
  return deliveryList.maybeWhen(
    data: (deliveryList) => deliveryList
        .where((delivery) => delivery.status == DeliveryStatusType.orderable)
        .toList(),
    orElse: () => [],
  );
});
