import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/purchases/repositories/user_purchase_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PurchaseListNotifier extends ListNotifier<Purchase> {
  final UserPurchaseRepository userPurchaseRepository;
  AsyncValue<List<Purchase>> purchaseList = const AsyncValue.loading();
  PurchaseListNotifier(this.userPurchaseRepository)
    : super(const AsyncValue.loading());

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
      final userPurchaseRepository = ref.watch(userPurchaseRepositoryProvider);
      PurchaseListNotifier notifier = PurchaseListNotifier(
        userPurchaseRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPurchases();
      });
      return notifier;
    });
