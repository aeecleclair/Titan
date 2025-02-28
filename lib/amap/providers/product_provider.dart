import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class ProductNotifier
    extends StateNotifier<AppModulesAmapSchemasAmapProductComplete> {
  ProductNotifier()
      : super(AppModulesAmapSchemasAmapProductComplete.fromJson({}));

  void setProduct(AppModulesAmapSchemasAmapProductComplete product) {
    state = product;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier,
    AppModulesAmapSchemasAmapProductComplete>((ref) {
  return ProductNotifier();
});
