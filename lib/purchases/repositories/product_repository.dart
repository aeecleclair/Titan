import 'package:titan/purchases/class/product.dart';
import 'package:titan/tools/repository/repository.dart';

class ProductRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/sellers/";

  Future<List<Product>> getProductList(String sellerId) async {
    return List<Product>.from(
      (await getList(
        suffix: "$sellerId/products/",
      )).map((x) => Product.fromJson(x)),
    );
  }
}
