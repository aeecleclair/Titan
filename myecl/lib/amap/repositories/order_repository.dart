import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderRepository extends Repository {
  @override
  final ext = "orders/";

  Future<bool> updateOrder(String orderId, Order order) async {
    return await update(order.toJson(), orderId);
  }

  Future<bool> deleteOrder(String orderId) async {
    return await delete(orderId);
  }

  Future<Order> getOrder(String orderId) async {
    return Order.fromJson(await getOne(orderId));
  }

  Future<Order> createOrder(Order order) async {
    return Order.fromJson(await create(order.toJson()));
  }
}
