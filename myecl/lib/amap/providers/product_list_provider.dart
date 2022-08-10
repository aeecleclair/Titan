import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/product_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final _productListRepository = ProductListRepository();
  late String deliveryId;
  ProductListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _productListRepository.setToken(token);
  }

  Future<AsyncValue<List<Product>>> loadProductList() async {
    try {
      final productList = await _productListRepository.getProductList();
      state = AsyncValue.data(productList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addProduct(Product product) async {
    return state.when(
      data: (products) async {
        try {
          Product newProduct = await _productListRepository.createProduct(product);
          products.add(newProduct);
          state = AsyncValue.data(products);
          return true;
        } catch (e) {
          state = AsyncValue.data(products);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add product while loading");
        return false;
      },
    );
  }

  Future<bool> updateProduct(Product product) async {
    return state.when(
      data: (products) async {
        try {
          await _productListRepository.updateProduct(product);
          var index = products.indexWhere((p) => p.id == product.id);
          products.remove(products.firstWhere((e) => e.id == product.id));
          products.insert(index, product);
          state = AsyncValue.data(products);
          return true;
        } catch (e) {
          state = AsyncValue.data(products);
        }
        return false;
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update product while loading");
        return false;
      },
    );
  }

  Future<bool> deleteProduct(String productId) async {
    return state.when(
      data: (products) async {
        try {
          await _productListRepository.deleteProduct(productId);
          products.removeWhere((element) => element.id == productId);
          state = AsyncValue.data(products);
          return true;
        } catch (e) {
          state = AsyncValue.data(products);
        }
        return false;
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete product while loading");
        return false;
      },
    );
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final token = ref.read(tokenProvider);
  ProductListNotifier _productListNotifier = ProductListNotifier(token: token);
  _productListNotifier.loadProductList();
  return _productListNotifier;
});
