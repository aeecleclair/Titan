import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryNameProvider =
    StateNotifierProvider<DeliveryNameProvider, String>((ref) {
      return DeliveryNameProvider("");
    });

class DeliveryNameProvider extends StateNotifier<String> {
  DeliveryNameProvider(super.id);

  void setName(String i) {
    state = i;
  }
}
