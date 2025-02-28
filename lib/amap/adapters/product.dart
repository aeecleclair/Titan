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
}
