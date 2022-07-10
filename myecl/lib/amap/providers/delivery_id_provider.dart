import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';

final deliveryIdProvider = StateNotifierProvider<DeliveryIdProvider, String>((ref) {
  final deliveries = ref.watch(deliveryList);
  return DeliveryIdProvider(deliveries[0].id,
  );
});

class DeliveryIdProvider extends StateNotifier<String> {
  DeliveryIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}
