import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class PurchaseNotifier extends SingleNotifier<PurchaseReturn> {
  @override
  AsyncValue<PurchaseReturn> build() {
    return const AsyncValue.loading();
  }

  void setPurchase(PurchaseReturn i) {
    state = AsyncValue.data(i);
  }
}

final purchaseProvider =
    NotifierProvider<PurchaseNotifier, AsyncValue<PurchaseReturn>>(
      PurchaseNotifier.new,
    );
