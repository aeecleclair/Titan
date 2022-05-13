import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceProvider = StateNotifierProvider<OrderPriceNotifier, double>((ref) {
  return OrderPriceNotifier();
});

class OrderPriceNotifier extends StateNotifier<double> {
  OrderPriceNotifier() : super(0.0);

  void setOrderPrice(double i) {
    state = i;
  }
}
