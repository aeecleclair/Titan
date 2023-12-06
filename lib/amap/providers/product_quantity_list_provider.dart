import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ProductQuantityListNotifier extends StateNotifier<List<ProductQuantity>> {
  ProductQuantityListNotifier(List<ProductComplete> products)
      : super(
          products
              .map((e) => ProductQuantity(
                    product: e,
                    quantity: 0,
                  ))
              .toList(),
        );

  void setProductQuantity(ProductQuantity productQuantity) {
    final index = state.indexWhere(
      (element) => element.product.id == productQuantity.product.id,
    );
    if (index != -1) {
      final copy = state.toList();
      copy[index] = productQuantity;
      state = copy;
    }
  }
}

final productQuantityListProvider =
    StateNotifierProvider<ProductQuantityListNotifier, List<ProductQuantity>>(
        (ref) {
  final productList = ref.watch(productListProvider);
  return productList.maybeWhen(
    data: (products) => ProductQuantityListNotifier(products),
    orElse: () => ProductQuantityListNotifier([]),
  );
});
