import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryIdProvider extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setId(String i) {
    state = i;
  }
}

final deliveryIdProvider = NotifierProvider<DeliveryIdProvider, String>(
  DeliveryIdProvider.new,
);
