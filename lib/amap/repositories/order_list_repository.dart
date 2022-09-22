import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries/";

  Future<Order> createOrder(
      String deliveryId, Order order, String userId) async {
    Map<String, dynamic> orderJson = order.toJson()
      ..addAll({
        "user_id": userId,
      });
    return Order.fromJson(
        await create(orderJson, suffix: "$deliveryId/orders"));
  }

  Future<bool> updateOrder(
      String deliveryId, Order order, String userId) async {
    Map<String, dynamic> orderJson = order.toJson()
      ..addAll({
        "user_id": userId,
      });
    return await update(orderJson, deliveryId, suffix: "/orders");
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
    return List<Order>.from(
        (await getList(suffix: "$deliveryId/orders")).map((x) => Order.fromJson(x)));
  }
}
