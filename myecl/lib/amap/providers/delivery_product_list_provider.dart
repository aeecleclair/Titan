import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final _productListRepository = DeliveryProductListRepository();
  late String deliveryId;
  ProductListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _productListRepository.setToken(token);
  }

  void setId(String id) {
    deliveryId = id;
  }

  Future<AsyncValue<List<Product>>> loadProductList() async {
    if (deliveryId.isEmpty) {
      return const AsyncValue.error(
          'deliveryId is null, please set deliveryId before load product list');
    }
    try {
      final productList =
          await _productListRepository.getProductList(deliveryId);
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
          await _productListRepository.createProduct(deliveryId, product);
          products.add(product);
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
          await _productListRepository.updateProduct(deliveryId, product);
          var index = products.indexWhere((p) => p.id == product.id);
          products.remove(products.firstWhere((e) => e.id == product.id));
          products.insert(index, product);
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
        state = const AsyncValue.error("Cannot update product while loading");
        return false;
      },
    );
  }

  Future<bool> deleteProduct(String productId) async {
    return state.when(
      data: (products) async {
        try {
          await _productListRepository.deleteProduct(deliveryId, productId);
          products.removeWhere((element) => element.id == productId);
          state = AsyncData(products);
          return true;
        } catch (e) {
          state = AsyncData(products);
          return false;
        }
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

  Future<bool> setQuantity(String productId, int i) async {
    return state.when(
      data: (products) async {
        try {
          var index = products.indexWhere((p) => p.id == productId);
          Product product = products[index].copyWith(quantity: i);
          products.remove(products.firstWhere((e) => e.id == productId));
          products.insert(index, product);
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
        state = const AsyncValue.error("Cannot update product while loading");
        return false;
      },
    );
  }

  Future<bool> resetQuantity() async {
    return state.when(
      data: (products) async {
        try {
          state = AsyncValue.data(products
              .map((e) => Product(
                  id: e.id,
                  name: e.name,
                  price: e.price,
                  quantity: 0,
                  category: e.category))
              .toList());
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
        state = const AsyncValue.error("Cannot reset quantity while loading");
        return false;
      },
    );
  }
}

final deliveryProductListProvider = StateNotifierProvider.family<
    ProductListNotifier, AsyncValue<List<Product>>, String>((ref, deliveryId) {
  final token = ref.watch(tokenProvider);
  ProductListNotifier _productListNotifier = ProductListNotifier(token: token);
  _productListNotifier.setId(deliveryId);
  _productListNotifier.loadProductList();
  return _productListNotifier;
});
