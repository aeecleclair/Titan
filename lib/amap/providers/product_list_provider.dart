import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ProductListNotifier
    extends ListNotifierAPI<AppModulesAmapSchemasAmapProductComplete> {
  Openapi get productListRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>> build() {
    loadProductList();
    return const AsyncValue.loading();
  }

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
        body: AppModulesAmapSchemasAmapProductEdit(
          category: product.category,
          name: product.name,
          price: product.price,
        ),
      ),
      (product) => product.id,
      product,
    );
  }

  Future<bool> deleteProduct(
    AppModulesAmapSchemasAmapProductComplete product,
  ) async {
    return await delete(
      () => productListRepository.amapProductsProductIdDelete(
        productId: product.id,
      ),
      (product) => product.id,
      product.id,
    );
  }
}

final productListProvider =
    NotifierProvider<
      ProductListNotifier,
      AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>
    >(ProductListNotifier.new);
