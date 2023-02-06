import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries/";

  Future<Order> createOrder(
      String deliveryId, Order order, String userId) async {
    return Order.fromJson(
        await create(order.toJson(), suffix: "$deliveryId/orders"));
  }

  Future<bool> updateOrder(
      String deliveryId, Order order, String userId) async {
    return await update(order.toJson(), deliveryId, suffix: "/orders/${order.id}");
  }

  Future<bool> deleteOrder(String deliveryId, String orderId) async {
    return await delete(deliveryId, suffix: "/orders/$orderId");
  }

  Future<List<Order>> getOrder(String deliveryId, String orderId) async {
    return List<Order>.from(
        (await getList(suffix: "$deliveryId/orders/$orderId"))
            .map((x) => Order.fromJson(x)));
  }

  Future<List<Order>> getDeliveryOrderList(String deliveryId) async {
    return List<Order>.from((await getList(suffix: "$deliveryId/orders"))
        .map((x) => Order.fromJson(x)));
  }
}
