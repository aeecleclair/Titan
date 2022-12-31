import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';

final sortedByCategoryProductsProvider =
    Provider<Map<String, List<Product>>>((ref) {
  final products = ref.watch(productList);
  final sortedByCategoryProducts = <String, List<Product>>{};
  for (var product in products) {
    if (sortedByCategoryProducts.containsKey(product.category)) {
      sortedByCategoryProducts[product.category]!.add(product);
    } else {
      sortedByCategoryProducts[product.category] = [product];
    }
  }
  return sortedByCategoryProducts;
});

final productList = Provider<List<Product>>((ref) {
  final products = ref.watch(productListProvider);
  return products.when(
    data: (products) => products,
    loading: () => [],
    error: (error, stack) => [],
  );
});
