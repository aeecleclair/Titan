import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/amap/adapters/product.dart';

class ProductListNotifier
    extends ListNotifierAPI<AppModulesAmapSchemasAmapProductComplete> {
  final Openapi productListRepository;
  ProductListNotifier({required this.productListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>
      loadProductList() async {
    return await loadList(productListRepository.amapProductsGet);
  }

  Future<bool> addProduct(ProductSimple product) async {
    return await add(
      () => productListRepository.amapProductsPost(body: product),
      product,
    );
  }

  Future<bool> updateProduct(
    AppModulesAmapSchemasAmapProductComplete product,
  ) async {
    return await update(
      () => productListRepository.amapProductsProductIdPatch(
        productId: product.id,
        body: product.toProductEdit(),
      ),
      (product) => product.id,
      product,
    );
  }

  Future<bool> deleteProduct(String productId) async {
    return await delete(
      () => productListRepository.amapProductsProductIdDelete(
        productId: productId,
      ),
      (p) => p.id,
      productId,
    );
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier,
    AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>((ref) {
  final productListRepository = ref.watch(repositoryProvider);
  return ProductListNotifier(productListRepository: productListRepository)
    ..loadProductList();
});
