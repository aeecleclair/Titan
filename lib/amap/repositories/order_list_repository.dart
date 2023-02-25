import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/orders";

  Future<Order> createOrder(Order order) async {
    return Order.fromJson(
        await create(order.toJson()));
  }

  Future<bool> updateOrder(Order order) async {
    return await update(order.toJson(), "/${order.id}");
  }

  Future<bool> deleteOrder(String orderId) async {
    return await delete("/$orderId");
  }

  Future<List<Order>> getOrder(String orderId) async {
    return List<Order>.from(
        (await getList(suffix: "/$orderId"))
            .map((x) => Order.fromJson(x)));
  }

  Future<List<Order>> getDeliveryOrderList(String deliveryId) async {
    return List<Order>.from((await getList(suffix: "$deliveryId/orders"))
        .map((x) => Order.fromJson(x)));
  }
}
