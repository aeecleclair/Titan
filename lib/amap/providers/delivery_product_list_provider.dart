import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class DeliveryProductListNotifier extends ListNotifier2<ProductComplete> {
  final Openapi productListRepository;
  DeliveryProductListNotifier({required this.productListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ProductComplete>>> loadProductList(
      List<ProductComplete> products) async {
    return loadFromList(products);
  }

  Future<bool> addProduct(ProductComplete product, String deliveryId) async {
    return await update(
        (product) async =>
            productListRepository.amapDeliveriesDeliveryIdProductsPost(
                deliveryId: deliveryId,
                body: DeliveryProductsUpdate(
                  productsIds: [product.id],
                )),
        (products, product) => products..add(product),
        product);
  }

  Future<bool> deleteProduct(ProductComplete product, String deliveryId) async {
    return await delete(
        (productId) async =>
            productListRepository.amapDeliveriesDeliveryIdProductsDelete(
                deliveryId: deliveryId,
                body: DeliveryProductsUpdate(
                  productsIds: [productId],
                )),
        (products, product) => products..removeWhere((i) => i.id == product.id),
        product.id,
        product);
  }
}

final deliveryProductListProvider = StateNotifierProvider<
    DeliveryProductListNotifier, AsyncValue<List<ProductComplete>>>((ref) {
  final deliveryProductListRepository = ref.watch(repositoryProvider);
  return DeliveryProductListNotifier(
      productListRepository: deliveryProductListRepository);
});
