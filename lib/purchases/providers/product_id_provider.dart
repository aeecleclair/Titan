import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ProductIdNotifier extends SingleNotifier<String> {
  ProductIdNotifier() : super(const AsyncValue.loading());

  void setProductId(String i) {
    state = AsyncValue.data(i);
  }
}

final productIdProvider =
    StateNotifierProvider<ProductIdNotifier, AsyncValue<String>>((ref) {
  ProductIdNotifier notifier = ProductIdNotifier();
  return notifier;
});
