import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class PurchaseNotifier extends SingleNotifier<PurchaseReturn> {
  PurchaseNotifier() : super(const AsyncValue.loading());

  void setPurchase(PurchaseReturn i) {
    state = AsyncValue.data(i);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, AsyncValue<PurchaseReturn>>((ref) {
  PurchaseNotifier notifier = PurchaseNotifier();
  return notifier;
});
