import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class PurchaseNotifier extends SingleNotifier<Purchase> {
  PurchaseNotifier({required String token}) : super(const AsyncValue.loading());

  void setPurchase(Purchase i) {
    state = AsyncValue.data(i);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, AsyncValue<Purchase>>((ref) {
  final token = ref.watch(tokenProvider);
  PurchaseNotifier notifier = PurchaseNotifier(token: token);
  return notifier;
});
