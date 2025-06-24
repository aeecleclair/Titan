import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class ProductListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/products";

  Future<List<Product>> getProductList() async {
    return List<Product>.from(
      (await getList()).map((x) => Product.fromJson(x)),
    );
  }

  Future<Product> getProduct(String productId) async {
    return Product.fromJson(await getOne("/$productId"));
  }

  Future<Product> createProduct(Product product) async {
    return Product.fromJson(await create(product.toJson()));
  }

  Future<bool> updateProduct(Product product) async {
    return await update(product.toJson(), "/${product.id}");
  }

  Future<bool> deleteProduct(String productId) async {
    return await delete("/$productId");
  }
}

final productListRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return ProductListRepository()..setToken(token);
});
