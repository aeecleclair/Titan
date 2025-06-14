import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/repositories/delivery_product_list_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class DeliveryProductListNotifier extends ListNotifier<Product> {
  final DeliveryProductListRepository productListRepository;
  DeliveryProductListNotifier({required this.productListRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Product>>> loadProductList(
    List<Product> products,
  ) async {
    return state = AsyncValue.data(products);
  }

  Future<bool> addProduct(Product product, String deliveryId) async {
    return await add(
      (p) async => productListRepository.createProduct(deliveryId, p),
      product,
    );
  }

  Future<bool> updateProduct(Product product, String deliveryId) async {
    return await update(
      (p) async => productListRepository.updateProduct(deliveryId, p),
      (products, product) =>
          products..[products.indexWhere((p) => p.id == product.id)] = product,
      product,
    );
  }

  Future<bool> deleteProduct(Product product, String deliveryId) async {
    return await delete(
      (id) async => productListRepository.deleteProduct(deliveryId, id),
      (products, product) => products..removeWhere((i) => i.id == product.id),
      product.id,
      product,
    );
  }

  Future<bool> setQuantity(Product product, int i) async {
    return await update(
      (p) async => true,
      (products, product) => products
        ..[products.indexWhere((p) => p.id == product.id)] = product.copyWith(
          quantity: i,
        ),
      product,
    );
  }
}

final deliveryProductListProvider =
    StateNotifierProvider<
      DeliveryProductListNotifier,
      AsyncValue<List<Product>>
    >((ref) {
      final deliveryProductListRepository = ref.watch(
        deliveryProductListRepositoryProvider,
      );
      return DeliveryProductListNotifier(
        productListRepository: deliveryProductListRepository,
      );
    });
