import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ProductListNotifier
    extends ListNotifierAPI<AppModulesCdrSchemasCdrProductComplete> {
  final Openapi productRepository;
  ProductListNotifier({required this.productRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AppModulesCdrSchemasCdrProductComplete>>> loadProducts(
    String sellerId,
  ) async {
    return await loadList(
      () => productRepository.cdrSellersSellerIdProductsGet(sellerId: sellerId),
    );
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier,
    AsyncValue<List<AppModulesCdrSchemasCdrProductComplete>>>((ref) {
  final productRepository = ref.watch(repositoryProvider);
  ProductListNotifier notifier =
      ProductListNotifier(productRepository: productRepository);
  return notifier;
});
