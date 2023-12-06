import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

final sortedByCategoryDeliveryProductsProvider =
    Provider<Map<String, List<ProductComplete>>>((ref) {
  final products = ref.watch(deliveryProductList);
  final Map<String, List<ProductComplete>> sortedByCategoryProducts =
      <String, List<ProductComplete>>{};
  for (var product in products) {
    if (sortedByCategoryProducts.containsKey(product.category)) {
      sortedByCategoryProducts[product.category]!.add(product);
    } else {
      sortedByCategoryProducts[product.category] = [product];
    }
  }
  return sortedByCategoryProducts;
});

final deliveryProductList = Provider<List<ProductComplete>>((ref) {
  final products = ref.watch(deliveryProductListProvider);
  return products.maybeWhen(
    data: (products) => products,
    orElse: () => [],
  );
});
