import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final _productListRepository = DeliveryProductListRepository();
  List<Product> lastLoadedProducts = [];
  late String deliveryId;
  ProductListNotifier() : super(const AsyncValue.loading());

  void setId(String id) {
    deliveryId = id;
  }

  Future<AsyncValue<List<Product>>> loadProductList() async {
    try {
      final productList =
          await _productListRepository.getProductList(deliveryId);
      lastLoadedProducts = productList;
      state = AsyncValue.data(productList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addProduct(Product product) async {
    try {
      if (await _productListRepository.createProduct(deliveryId, product)) {
        lastLoadedProducts.add(product);
        state = AsyncValue.data(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to add product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> updateProduct(String productId, Product product) async {
    try {
      if (await _productListRepository.updateProduct(deliveryId, product)) {
        lastLoadedProducts.replaceRange(
            lastLoadedProducts.indexOf(lastLoadedProducts
                .firstWhere((element) => element.id == productId)),
            1,
            [product]);
        state = AsyncData(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to update product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      if (await _productListRepository.deleteProduct(deliveryId, productId)) {
        lastLoadedProducts.remove(lastLoadedProducts
            .firstWhere((element) => element.id == productId));
        state = AsyncData(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to delete product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> setQuantity(String productId, int i) async {
    try {
      var newProduct = lastLoadedProducts
          .firstWhere((element) => element.id == productId)
          .copyWith(quantity: i);
      var index = lastLoadedProducts.indexOf(
          lastLoadedProducts.firstWhere((element) => element.id == productId));
      lastLoadedProducts.removeWhere((element) => element.id == productId);
      lastLoadedProducts.insertAll(index, [newProduct]);
      state = AsyncData(lastLoadedProducts);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> resetQuantity() async {
    try {
      for (var element in lastLoadedProducts) {
        element = element.copyWith(quantity: 0);
      }
      state = AsyncData(lastLoadedProducts);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }
}

final deliveryProductListProvider = StateNotifierProvider.family<ProductListNotifier,
    AsyncValue<List<Product>>, String>((ref, deliveryId) {
  ProductListNotifier _productListNotifier = ProductListNotifier();
  _productListNotifier.setId(deliveryId);
  _productListNotifier.loadProductList();
  return _productListNotifier;
});
