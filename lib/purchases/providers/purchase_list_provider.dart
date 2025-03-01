import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PurchaseListNotifier extends ListNotifier2<PurchaseReturn> {
  final Openapi userPurchaseRepository;
  PurchaseListNotifier({required this.userPurchaseRepository})
      : super(const AsyncValue.loading());

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

final purchaseListProvider = StateNotifierProvider<PurchaseListNotifier,
    AsyncValue<List<PurchaseReturn>>>((ref) {
  final userPurchaseRepository = ref.watch(repositoryProvider);
  PurchaseListNotifier notifier =
      PurchaseListNotifier(userPurchaseRepository: userPurchaseRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadPurchases();
  });
  return notifier;
});
