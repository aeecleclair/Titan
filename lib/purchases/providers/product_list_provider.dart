import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/product.dart';
import 'package:myecl/purchases/repositories/product_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ProductListNotifier extends ListNotifier<Product> {
  final ProductRepository productRepository = ProductRepository();
  AsyncValue<List<Product>> productList = const AsyncValue.loading();
  ProductListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    productRepository.setToken(token);
  }

  Future<AsyncValue<List<Product>>> loadProducts(String sellerId) async {
    return await loadList(() => productRepository.getProductList(sellerId));
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  ProductListNotifier notifier = ProductListNotifier(token: token);
  return notifier;
});
