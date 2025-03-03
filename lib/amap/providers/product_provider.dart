import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class ProductNotifier
    extends StateNotifier<AppModulesAmapSchemasAmapProductComplete> {
  ProductNotifier()
      : super(EmptyModels.empty<AppModulesAmapSchemasAmapProductComplete>());

  void setProduct(AppModulesAmapSchemasAmapProductComplete product) {
    state = product;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier,
    AppModulesAmapSchemasAmapProductComplete>((ref) {
  return ProductNotifier();
});
