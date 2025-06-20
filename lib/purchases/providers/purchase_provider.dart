import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class PurchaseNotifier extends SingleNotifier<Purchase> {
  PurchaseNotifier() : super(const AsyncValue.loading());

  void setPurchase(Purchase i) {
    state = AsyncValue.data(i);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, AsyncValue<Purchase>>((ref) {
      PurchaseNotifier notifier = PurchaseNotifier();
      return notifier;
    });
