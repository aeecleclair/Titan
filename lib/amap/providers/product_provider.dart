import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ProductNotifier extends StateNotifier<ProductComplete> {
  ProductNotifier() : super(ProductComplete.fromJson({}));

  void setProduct(ProductComplete product) {
    state = product;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductComplete>((ref) {
  return ProductNotifier();
});
