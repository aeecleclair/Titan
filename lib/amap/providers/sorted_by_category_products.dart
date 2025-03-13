import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class SortedByCategoryProvider extends StateNotifier<
    Map<String, List<AppModulesAmapSchemasAmapProductComplete>>> {
  SortedByCategoryProvider(super.p);
}

final sortedByCategoryProductsProvider = StateNotifierProvider<
    SortedByCategoryProvider,
    Map<String, List<AppModulesAmapSchemasAmapProductComplete>>>((ref) {
  final products = ref.watch(productListProvider);
  final sortedByCategoryProducts =
      <String, List<AppModulesAmapSchemasAmapProductComplete>>{};
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
    orElse: () {},
  );
  return SortedByCategoryProvider(sortedByCategoryProducts);
});
