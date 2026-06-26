import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class DeliveryProductListNotifier
    extends ListNotifierAPI<AppModulesAmapSchemasAmapProductComplete> {
  Openapi get productListRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>>
  loadProductList(
    List<AppModulesAmapSchemasAmapProductComplete> products,
  ) async {
    return state = AsyncValue.data(products);
  }

  // TODO: Require back changes, should return AppModulesAmapSchemasAmapProductComplete and not taking a list
  Future<bool> addProduct(
    DeliveryProductsUpdate product,
    String deliveryId,
  ) async {
    return await add(() async {
      final response = await productListRepository
          .amapDeliveriesDeliveryIdProductsPost(
            deliveryId: deliveryId,
            body: product,
          );
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to add product');
    }, product);
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
      (product) => product.id,
      product.id,
    );
  }
}

final deliveryProductListProvider =
    NotifierProvider<
      DeliveryProductListNotifier,
      AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>>
    >(() => DeliveryProductListNotifier());
