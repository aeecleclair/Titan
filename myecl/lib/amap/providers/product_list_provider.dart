import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/product_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class ProductListNotifier extends ListProvider<Product> {
  final ProductListRepository _productListRepository = ProductListRepository();
  late String deliveryId;
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
    return await update(_productListRepository.updateProduct,
        (products, product) {
      final productsId = products.map((p) => p.id).toList();
      final index = productsId.indexOf(product.id);
      products[index] = product;
      return products;
    }, product);
  }

  Future<bool> deleteProduct(Product product) async {
    return await delete(
        _productListRepository.deleteProduct, product.id, product);
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  ProductListNotifier _productListNotifier = ProductListNotifier(token: token);
  _productListNotifier.loadProductList();
  return _productListNotifier;
});
