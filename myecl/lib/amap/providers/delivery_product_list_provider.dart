import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class ProductListNotifier extends ListProvider<Product> {
  final _productListRepository = DeliveryProductListRepository();
  late String deliveryId;
  ProductListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _productListRepository.setToken(token);
  }

  void setId(String id) {
    deliveryId = id;
  }

  Future<AsyncValue<List<Product>>> loadProductList() async {
    return await loadList(() async {
      return await _productListRepository.getProductList(deliveryId);
    });
  }

  Future<bool> addProduct(Product product) async {
    return await add((p) {
      return _productListRepository.createProduct(deliveryId, p);
    }, product);
  }

  Future<bool> updateProduct(Product product) async {
    return await update((p) {
      return _productListRepository.updateProduct(deliveryId, p);
    }, product);
  }

  Future<bool> deleteProduct(Product product) async {
    return await delete((id) {
      return _productListRepository.deleteProduct(deliveryId, id);
    }, product.id, product);
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
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
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
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
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
