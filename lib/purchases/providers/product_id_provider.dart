import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class ProductIdNotifier extends SingleNotifier<String> {
  @override
  AsyncValue<String> build() {
    return const AsyncValue.loading();
  }

  void setProductId(String i) {
    state = AsyncValue.data(i);
  }
}

final productIdProvider =
    NotifierProvider<ProductIdNotifier, AsyncValue<String>>(
      ProductIdNotifier.new,
    );
