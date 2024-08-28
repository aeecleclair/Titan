import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PurchaseListNotifier extends ListNotifier<Purchase> {
  final UserInformationRepository purchaseRepository =
      UserInformationRepository();
  AsyncValue<List<Purchase>> purchaseList = const AsyncValue.loading();
  PurchaseListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    purchaseRepository.setToken(token);
  }

  Future<AsyncValue<List<Purchase>>> loadPurchases() async {
    return await loadList(purchaseRepository.getPurchaseList);
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
    StateNotifierProvider<PurchaseListNotifier, AsyncValue<List<Purchase>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  PurchaseListNotifier notifier = PurchaseListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadPurchases();
  });
  return notifier;
});
