import 'package:myecl/generated/openapi.models.swagger.dart';

extension $AppModulesAmapSchemasAmapProductComplete
    on AppModulesAmapSchemasAmapProductComplete {
  ProductSimple toProductSimple() {
    return ProductSimple(
      name: name,
      price: price,
      category: category,
    );
  }

  AppModulesAmapSchemasAmapProductEdit toProductEdit() {
    return AppModulesAmapSchemasAmapProductEdit(
      category: category,
      name: name,
      price: price,
    );
  }

  DeliveryProductsUpdate toDeliveryProductsUpdate() {
    return DeliveryProductsUpdate(productsIds: [id]);
  }
}
