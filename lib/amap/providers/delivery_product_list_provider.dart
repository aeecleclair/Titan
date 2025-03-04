import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/amap/adapters/product.dart';

class DeliveryProductListNotifier
    extends ListNotifierAPI<AppModulesAmapSchemasAmapProductComplete> {
  final Openapi productListRepository;
  DeliveryProductListNotifier({required this.productListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>
      loadProductList(
    List<AppModulesAmapSchemasAmapProductComplete> products,
  ) async {
    return state = AsyncValue.data(products);
  }

  // Require back changes, should return AppModulesAmapSchemasAmapProductComplete and not taking a list
  Future<bool> addProduct(
    DeliveryProductsUpdate product,
    String deliveryId,
  ) async {
    return await add(
      () async {
        final response =
            await productListRepository.amapDeliveriesDeliveryIdProductsPost(
          deliveryId: deliveryId,
          body: product,
        );
        if (response.isSuccessful && response.body != null) {
          return response.body!;
        }
        throw Exception('Failed to add product');
      },
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
        body: product.toDeliveryProductsUpdate(),
      ),
      (p) => p.id,
      product.id,
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
