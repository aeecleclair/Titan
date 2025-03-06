import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

final sortedByCategoryDeliveryProductsProvider =
    Provider<Map<String, List<AppModulesAmapSchemasAmapProductComplete>>>(
        (ref) {
  final products = ref.watch(deliveryProductList);
  final Map<String, List<AppModulesAmapSchemasAmapProductComplete>>
      sortedByCategoryProducts =
      <String, List<AppModulesAmapSchemasAmapProductComplete>>{};
  for (var product in products) {
    if (sortedByCategoryProducts.containsKey(product.category)) {
      sortedByCategoryProducts[product.category]!.add(product);
    } else {
      sortedByCategoryProducts[product.category] = [product];
    }
  }
  return sortedByCategoryProducts;
});

final deliveryProductList =
    Provider<List<AppModulesAmapSchemasAmapProductComplete>>((ref) {
  final products = ref.watch(deliveryProductListProvider);
  return products.maybeWhen(
    data: (products) => products,
    orElse: () => [],
  );
});
