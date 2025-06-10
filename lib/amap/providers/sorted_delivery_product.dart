import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/delivery_product_list_provider.dart';

final sortedByCategoryDeliveryProductsProvider =
    Provider<Map<String, List<Product>>>((ref) {
      final products = ref.watch(deliveryProductList);
      final Map<String, List<Product>> sortedByCategoryProducts =
          <String, List<Product>>{};
      for (var product in products) {
        if (sortedByCategoryProducts.containsKey(product.category)) {
          sortedByCategoryProducts[product.category]!.add(product);
        } else {
          sortedByCategoryProducts[product.category] = [product];
        }
      }
      return sortedByCategoryProducts;
    });

final deliveryProductList = Provider<List<Product>>((ref) {
  final products = ref.watch(deliveryProductListProvider);
  return products.maybeWhen(data: (products) => products, orElse: () => []);
});
