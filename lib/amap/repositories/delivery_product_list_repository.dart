import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class DeliveryProductListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries/";

  Future<Product> createProduct(String deliveryId, Product product) async {
    return Product.fromJson(
      await create(product.toJson(), suffix: "$deliveryId/products"),
    );
  }

  Future<bool> updateProduct(String deliveryId, Product product) async {
    return await update(
      product.toJson(),
      deliveryId,
      suffix: "/products/${product.id}",
    );
  }

  Future<bool> deleteProduct(String deliveryId, String productId) async {
    return await delete(deliveryId, suffix: "/products/$productId");
  }
}

final deliveryProductListRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return DeliveryProductListRepository()..setToken(token);
});
