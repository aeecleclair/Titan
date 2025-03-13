import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class OrderNotifier extends StateNotifier<OrderReturn> {
  OrderNotifier() : super(EmptyModels.empty<OrderReturn>());

  void setOrder(OrderReturn order) {
    state = order;
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderReturn>((ref) {
  return OrderNotifier();
});
