import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ProductListNotifier extends ListNotifier<Product> {
  final _productListRepository = DeliveryProductListRepository();
  ProductListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _productListRepository.setToken(token);
  }

  Future<AsyncValue<List<Product>>> loadProductList(String deliveryId) async {
    return await loadList(
        () async => _productListRepository.getProductList(deliveryId));
  }

  Future<bool> addProduct(Product product, String deliveryId) async {
    return await add(
        (p) async => _productListRepository.createProduct(deliveryId, p),
        product);
  }

  Future<bool> updateProduct(Product product, String deliveryId) async {
    return await update(
        (p) async => _productListRepository.updateProduct(deliveryId, p),
        (products, product) => products
          ..[products.indexWhere((p) => p.id == product.id)] = product,
        product);
  }

  Future<bool> deleteProduct(Product product, String deliveryId) async {
    return await delete(
        (id) async => _productListRepository.deleteProduct(deliveryId, id),
        (products, product) => products..removeWhere((i) => i.id == product.id),
        product.id,
        product);
  }

  Future<bool> setQuantity(Product product, int i) async {
    return await update(
        (p) async => true,
        (products, product) => products
          ..[products.indexWhere((p) => p.id == product.id)] = product,
        product.copyWith(quantity: i));
  }

  Future<bool> resetQuantity() async {
    return await update(
        (p) async => true,
        (products, p) => products.map((e) => e.copyWith(quantity: 0)).toList(),
        Product.empty());
  }
}

final deliveryProductListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  return ProductListNotifier(token: token);
});
