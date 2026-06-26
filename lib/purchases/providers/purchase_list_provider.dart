import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PurchaseListNotifier extends ListNotifierAPI<PurchaseReturn> {
  Openapi get userPurchaseRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<PurchaseReturn>> build() {
    loadPurchases();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<PurchaseReturn>>> loadPurchases() async {
    return await loadList(userPurchaseRepository.cdrMePurchasesGet);
  }

  List<int> getPurchasesYears() {
    List<int> years = [];
    state.maybeWhen(
      orElse: () => [],
      data: (value) {
        for (PurchaseReturn purchase in value) {
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
    NotifierProvider<PurchaseListNotifier, AsyncValue<List<PurchaseReturn>>>(
      PurchaseListNotifier.new,
    );
