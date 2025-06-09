import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/product.dart';
import 'package:myecl/tools/repository/repository.dart';

class ProductRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/sellers/";

  ProductRepository(super.ref);

  Future<List<Product>> getProductList(String sellerId) async {
    return List<Product>.from(
      (await getList(
        suffix: "$sellerId/products/",
      )).map((x) => Product.fromJson(x)),
    );
  }
}

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(ref),
);
