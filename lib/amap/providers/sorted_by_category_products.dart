import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';

class SortedByCategoryProvider
    extends StateNotifier<Map<String, List<Product>>> {
  SortedByCategoryProvider(Map<String, List<Product>> p) : super(p);
}

final sortedByCategoryProductsProvider =
    StateNotifierProvider<SortedByCategoryProvider, Map<String, List<Product>>>(
        (ref) {
  final products = ref.watch(productListProvider);
  final sortedByCategoryProducts = <String, List<Product>>{};
  products.maybeWhen(
      data: (products) {
        for (var product in products) {
          if (sortedByCategoryProducts.containsKey(product.category)) {
            sortedByCategoryProducts[product.category]!.add(product);
          } else {
            sortedByCategoryProducts[product.category] = [product];
          }
        }
      },
      orElse: () {});
  return SortedByCategoryProvider(sortedByCategoryProducts);
});
