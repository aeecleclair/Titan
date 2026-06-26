import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ProductListNotifier
    extends ListNotifierAPI<AppModulesCdrSchemasCdrProductComplete> {
  Openapi get productRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesCdrSchemasCdrProductComplete>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesCdrSchemasCdrProductComplete>>> loadProducts(
    String sellerId,
  ) async {
    return await loadList(
      () => productRepository.cdrSellersSellerIdProductsGet(sellerId: sellerId),
    );
  }
}

final productListProvider =
    NotifierProvider<
      ProductListNotifier,
      AsyncValue<List<AppModulesCdrSchemasCdrProductComplete>>
    >(ProductListNotifier.new);
