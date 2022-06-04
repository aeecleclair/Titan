import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryIdProvider = StateNotifierProvider<DeliveryIdProvider, String>((ref) {
  return DeliveryIdProvider();
});

class DeliveryIdProvider extends StateNotifier<String> {
  DeliveryIdProvider() : super('');

  void setId(String i) {
    state = i;
  }
}
