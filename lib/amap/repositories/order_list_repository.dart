import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/";

  OrderListRepository(super.ref);

  Future<Order> createOrder(Order order) async {
    return Order.fromJson(await create(order.toJson(), suffix: "orders"));
  }

  Future<bool> updateOrder(Order order) async {
    return await update(order.toJson(), "orders/${order.id}");
  }

  Future<bool> deleteOrder(String orderId) async {
    return await delete("orders/$orderId");
  }

  Future<List<Order>> getOrder(String orderId) async {
    return List<Order>.from(
      (await getList(suffix: "orders/$orderId")).map((x) => Order.fromJson(x)),
    );
  }

  Future<List<Order>> getDeliveryOrderList(String deliveryId) async {
    return List<Order>.from(
      (await getList(
        suffix: "deliveries/$deliveryId/orders",
      )).map((x) => Order.fromJson(x)),
    );
  }
}

final orderListRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return OrderListRepository(ref)..setToken(token);
});
