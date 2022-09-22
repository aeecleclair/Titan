import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/repository/repository.dart';

class DeliveryProductListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/deliveries/";

  Future<List<Product>> getProductList(String deliveryId) async {
    return List<Product>.from((await getList(suffix: "$deliveryId/products")).map((x) => Product.fromJson(x)));
  }

  Future<Product> createProduct(String deliveryId, Product product) async {
    return Product.fromJson(await create(product.toJson(), suffix: "$deliveryId/products"));
  }

  Future<bool> updateProduct(String deliveryId, Product product) async {
    return await update(product.toJson(), deliveryId, suffix: "/products/${product.id}");
  }

  Future<bool> deleteProduct(String deliveryId, String productId) async {
    return await delete(deliveryId, suffix: "/products/$productId");
  }
}
