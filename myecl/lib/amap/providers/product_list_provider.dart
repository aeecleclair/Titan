import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/product_repository.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final _productListRepository = ProductListRepository();
  late String deliveryId;
  ProductListNotifier() : super(const AsyncValue.loading());

  void setId(String id) {
    deliveryId = id;
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
          if (await _productListRepository.createProduct(product)) {
            products.add(product);
            state = AsyncValue.data(products);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to add product"));
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e);
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
          if (await _productListRepository.updateProduct(product)) {
            var index = products.indexWhere((p) => p.id == product.id);
            products.remove(products.firstWhere((e) => e.id == product.id));
            products.insert(index, product);
            state = AsyncValue.data(products);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to update product"));
          }
        } catch (e) {
          state = AsyncValue.error(e);
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
          if (await _productListRepository.deleteProduct(productId)) {
            products.removeWhere((element) => element.id == productId);
            state = AsyncData(products);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to delete product"));
          }
        } catch (e) {
          state = AsyncValue.error(e);
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

final productListProvider = StateNotifierProvider.family<ProductListNotifier,
    AsyncValue<List<Product>>, String>((ref, deliveryId) {
  ProductListNotifier _productListNotifier = ProductListNotifier();
  _productListNotifier.setId(deliveryId);
  _productListNotifier.loadProductList();
  return _productListNotifier;
});
