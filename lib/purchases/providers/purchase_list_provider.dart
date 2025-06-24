import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/class/purchase.dart';
import 'package:titan/purchases/repositories/user_purchase_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PurchaseListNotifier extends ListNotifier<Purchase> {
  final UserPurchaseRepository userPurchaseRepository =
      UserPurchaseRepository();
  AsyncValue<List<Purchase>> purchaseList = const AsyncValue.loading();
  PurchaseListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    userPurchaseRepository.setToken(token);
  }

  Future<AsyncValue<List<Purchase>>> loadPurchases() async {
    return await loadList(userPurchaseRepository.getPurchaseList);
  }

  List<int> getPurchasesYears() {
    List<int> years = [];
    state.maybeWhen(
      orElse: () => [],
      data: (value) {
        for (Purchase purchase in value) {
          if (!years.contains(purchase.purchasedOn.year)) {
            years.add(purchase.purchasedOn.year);
          }
        }
      },
    );
    return years;
  }
}

final purchaseListProvider =
    StateNotifierProvider<PurchaseListNotifier, AsyncValue<List<Purchase>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      PurchaseListNotifier notifier = PurchaseListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPurchases();
      });
      return notifier;
    });
