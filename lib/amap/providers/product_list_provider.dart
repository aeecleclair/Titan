import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/product_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductListNotifier extends ListNotifier<Product> {
  final ProductListRepository _productListRepository = ProductListRepository();
  ProductListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _productListRepository.setToken(token);
  }

  Future<AsyncValue<List<Product>>> loadProductList() async {
    return await loadList(_productListRepository.getProductList);
  }

  Future<bool> addProduct(Product product) async {
    return await add(_productListRepository.createProduct, product);
  }

  Future<bool> updateProduct(Product product) async {
    return await update(
        _productListRepository.updateProduct,
        (products, product) => products
          ..[products.indexWhere((p) => p.id == product.id)] = product,
        product);
  }

  Future<bool> deleteProduct(Product product) async {
    return await delete(
        _productListRepository.deleteProduct,
        (products, product) => products..removeWhere((i) => i.id == product.id),
        product.id,
        product);
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  ProductListNotifier productListNotifier = ProductListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    productListNotifier.loadProductList();
  });
  return productListNotifier;
});
