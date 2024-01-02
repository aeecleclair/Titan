import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class SortedByCategoryProvider
    extends StateNotifier<Map<String, List<ProductComplete>>> {
  SortedByCategoryProvider(super.p);
}

final sortedByCategoryProductsProvider = StateNotifierProvider<
    SortedByCategoryProvider, Map<String, List<ProductComplete>>>((ref) {
  final products = ref.watch(productListProvider);
  final sortedByCategoryProducts = <String, List<ProductComplete>>{};
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
