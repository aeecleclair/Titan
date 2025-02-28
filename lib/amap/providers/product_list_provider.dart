import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductListNotifier
    extends ListNotifier2<AppModulesAmapSchemasAmapProductComplete> {
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
      AppModulesAmapSchemasAmapProductComplete product) async {
    return await update(
      () => productListRepository.amapProductsProductIdPatch(
        productId: product.id,
        body: AppModulesAmapSchemasAmapProductEdit(
          category: product.category,
          name: product.name,
          price: product.price,
        ),
      ),
      (products, product) =>
          products..[products.indexWhere((p) => p.id == product.id)] = product,
      product,
    );
  }

  Future<bool> deleteProduct(
      AppModulesAmapSchemasAmapProductComplete product) async {
    return await delete(
      () => productListRepository.amapProductsProductIdDelete(
          productId: product.id),
      (products, product) => products..removeWhere((i) => i.id == product.id),
      product,
    );
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier,
    AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>((ref) {
  final productListRepository = ref.watch(repositoryProvider);
  ProductListNotifier productListNotifier =
      ProductListNotifier(productListRepository: productListRepository);
  tokenExpireWrapperAuth(ref, () async {
    productListNotifier.loadProductList();
  });
  return productListNotifier;
});
