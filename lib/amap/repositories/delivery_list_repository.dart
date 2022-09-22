import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/repository/repository.dart';

class DeliveryListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries";

  Future<List<Delivery>> getDeliveryList() async {
    return List<Delivery>.from(
        (await getList()).map((x) => Delivery.fromJson(x)));
  }

  Future<Delivery> createDelivery(Delivery delivery) async {
    return Delivery.fromJson(await create(delivery.toJson()));
  }

  Future<bool> updateDelivery(Delivery delivery) async {
    return await update(delivery.toJson(), "/${delivery.id}");
  }

  Future<bool> deleteDelivery(String deliveryId) async {
    return await delete("/$deliveryId");
  }

  Future<Delivery> getDelivery(String deliveryId) async {
    return Delivery.fromJson(await getOne("/$deliveryId"));
  }

  Future<List<Product>> getAllProductsFromOrder(
      String deliveryId, String orderId) async {
    return List<Product>.from((await getList(
            suffix: "/$deliveryId/orders/$orderId/products"))
        .map((x) => Product.fromJson(x)));
  }
}
