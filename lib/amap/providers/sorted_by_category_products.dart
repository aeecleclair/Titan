import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SortedByCategoryProvider
    extends
        Notifier<Map<String, List<AppModulesAmapSchemasAmapProductComplete>>> {
  @override
  Map<String, List<AppModulesAmapSchemasAmapProductComplete>> build() {
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
    return sortedByCategoryProducts;
  }
}

final sortedByCategoryProductsProvider =
    NotifierProvider<
      SortedByCategoryProvider,
      Map<String, List<AppModulesAmapSchemasAmapProductComplete>>
    >(() => SortedByCategoryProvider());
