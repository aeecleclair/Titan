import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/product.dart';

class ProductNotifier extends StateNotifier<Product> {
  ProductNotifier() : super(Product.empty());

  void setProduct(Product product) {
    state = product;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, Product>((ref) {
  return ProductNotifier();
});
