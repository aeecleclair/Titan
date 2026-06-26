import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class OrderNotifier extends Notifier<OrderReturn> {
  @override
  OrderReturn build() {
    return OrderReturn.empty();
  }

  void setOrder(OrderReturn order) {
    state = order;
  }
}

final orderProvider = NotifierProvider<OrderNotifier, OrderReturn>(
  OrderNotifier.new,
);
