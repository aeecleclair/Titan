import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class DeliveryProductListNotifier
    extends ListNotifier2<AppModulesAmapSchemasAmapProductComplete> {
  final Openapi productListRepository;
  DeliveryProductListNotifier({required this.productListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>
      loadProductList(
    List<AppModulesAmapSchemasAmapProductComplete> products,
  ) async {
    return state = AsyncValue.data(products);
  }

  // require some work
  Future<bool> addProduct(
    DeliveryProductsUpdate product,
    String deliveryId,
  ) async {
    return await add(
      () => productListRepository.amapDeliveriesDeliveryIdProductsPost(
          deliveryId: deliveryId, body: product),
      product,
    );
  }

  Future<bool> deleteProduct(
    AppModulesAmapSchemasAmapProductComplete product,
    String deliveryId,
  ) async {
    return await delete(
      () async => productListRepository.amapDeliveriesDeliveryIdProductsDelete(
        deliveryId: deliveryId,
        body: DeliveryProductsUpdate(productsIds: [product.id]),
      ),
      (products, product) => products..removeWhere((i) => i.id == product.id),
      product,
    );
  }
}

final deliveryProductListProvider = StateNotifierProvider<
    DeliveryProductListNotifier,
    AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>((ref) {
  final deliveryProductListRepository = ref.watch(repositoryProvider);
  return DeliveryProductListNotifier(
    productListRepository: deliveryProductListRepository,
  );
});
