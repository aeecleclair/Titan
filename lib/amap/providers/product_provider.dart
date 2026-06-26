import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class ProductNotifier
    extends Notifier<AppModulesAmapSchemasAmapProductComplete> {
  @override
  AppModulesAmapSchemasAmapProductComplete build() {
    return AppModulesAmapSchemasAmapProductComplete.empty();
  }

  void setProduct(AppModulesAmapSchemasAmapProductComplete product) {
    state = product;
  }
}

final productProvider =
    NotifierProvider<ProductNotifier, AppModulesAmapSchemasAmapProductComplete>(
      ProductNotifier.new,
    );
