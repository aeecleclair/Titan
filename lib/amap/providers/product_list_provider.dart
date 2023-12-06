import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductListNotifier extends ListNotifier2<ProductComplete> {
  final Openapi productListRepository;
  ProductListNotifier({required this.productListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ProductComplete>>> loadProductList() async {
    return await loadList(productListRepository.amapProductsGet);
  }

  Future<bool> addProduct(ProductComplete product) async {
    return await add(
        (product) async => productListRepository.amapProductsPost(
                body: ProductSimple(
              name: product.name,
              price: product.price,
              category: product.category,
            )),
        product);
  }

  Future<bool> updateProduct(ProductComplete product) async {
    return await update(
        (product) async => productListRepository.amapProductsProductIdPatch(
            productId: product.id,
            body: ProductEdit(
              name: product.name,
              price: product.price,
              category: product.category,
            )),
        (products, product) => products
          ..[products.indexWhere((p) => p.id == product.id)] = product,
        product);
  }

  Future<bool> deleteProduct(ProductComplete product) async {
    return await delete(
        (productId) async => productListRepository.amapProductsProductIdDelete(
            productId: productId),
        (products, product) => products..removeWhere((i) => i.id == product.id),
        product.id,
        product);
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier,
    AsyncValue<List<ProductComplete>>>((ref) {
  final productListRepository = ref.watch(repositoryProvider);
  ProductListNotifier productListNotifier =
      ProductListNotifier(productListRepository: productListRepository);
  tokenExpireWrapperAuth(ref, () async {
    productListNotifier.loadProductList();
  });
  return productListNotifier;
});
