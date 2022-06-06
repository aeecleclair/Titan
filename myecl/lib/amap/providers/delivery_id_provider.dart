import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryIdProvider = StateNotifierProvider<DeliveryIdProvider, String>((ref) {
  // final deliveries = ref.watch(deliveryList);
  return DeliveryIdProvider('ce1de53c-aec5-4b31-a575-a2d7c3f90f3d', //TODO:
  );
});

class DeliveryIdProvider extends StateNotifier<String> {
  DeliveryIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}
