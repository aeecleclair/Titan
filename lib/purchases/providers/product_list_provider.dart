import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/product.dart';
import 'package:myecl/purchases/repositories/product_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ProductListNotifier extends ListNotifier<Product> {
  final ProductRepository productRepository;
  AsyncValue<List<Product>> productList = const AsyncValue.loading();
  ProductListNotifier(this.productRepository)
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Product>>> loadProducts(String sellerId) async {
    return await loadList(() => productRepository.getProductList(sellerId));
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>((
      ref,
    ) {
      final productRepository = ref.watch(productRepositoryProvider);
      ProductListNotifier notifier = ProductListNotifier(productRepository);
      return notifier;
    });
