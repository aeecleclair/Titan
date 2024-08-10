import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/product.dart';

class ProductNotifier extends StateNotifier<Product> {
  ProductNotifier({required String token}) : super(Product.empty());

  void setProduct(Product i) {
    state = i;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, Product>((ref) {
  final token = ref.watch(tokenProvider);
  ProductNotifier notifier = ProductNotifier(token: token);
  return notifier;
});
