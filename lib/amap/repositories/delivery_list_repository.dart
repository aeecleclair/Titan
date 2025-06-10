import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class DeliveryListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries";

  Future<List<Delivery>> getDeliveryList() async {
    return List<Delivery>.from(
      (await getList()).map((x) => Delivery.fromJson(x)),
    );
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

  Future<bool> openDelivery(Delivery delivery) async {
    return await create("", suffix: "/${delivery.id}/openordering");
  }

  Future<bool> lockDelivery(Delivery delivery) async {
    return await create("", suffix: "/${delivery.id}/lock");
  }

  Future<bool> deliverDelivery(Delivery delivery) async {
    return await create("", suffix: "/${delivery.id}/delivered");
  }

  Future<bool> archiveDelivery(String deliveryId) async {
    return await create("", suffix: "/$deliveryId/archive");
  }

  Future<List<Product>> getAllProductsFromOrder(
    String deliveryId,
    String orderId,
  ) async {
    return List<Product>.from(
      (await getList(
        suffix: "/$deliveryId/orders/$orderId/products",
      )).map((x) => Product.fromJson(x)),
    );
  }
}

final deliveryListRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return DeliveryListRepository()..setToken(token);
});
