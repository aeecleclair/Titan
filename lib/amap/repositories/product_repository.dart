import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/repository/repository.dart';

class ProductListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/products";

  Future<List<Product>> getProductList() async {
    return List<Product>.from(
        (await getList()).map((x) => Product.fromJson(x)));
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
