import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/order.dart';

class OrderNotifier extends StateNotifier<Order> {
  OrderNotifier() : super(Order.empty());

  void setOrder(Order order) {
    state = order;
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, Order>((ref) {
  return OrderNotifier();
});
