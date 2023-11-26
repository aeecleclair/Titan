import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class OrderNotifier extends StateNotifier<OrderReturn> {
  OrderNotifier() : super(OrderReturn.fromJson({}));

  void setOrder(OrderReturn order) {
    state = order;
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderReturn>((ref) {
  return OrderNotifier();
});
