import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_provider.dart';

class ItemQuantitiesMapNotifier extends StateNotifier<Map<String, int>> {
  ItemQuantitiesMapNotifier() : super(<String, int>{});

  Future<Map<String, int>> toggle(String id, int quantity) async {
    state[id] = state[id] == 0 ? quantity : 0;
    state = Map.from(state);
    return state;
  }

  Future<Map<String, int>> set(String id, int quantity) async {
    state[id] = quantity;
    state = Map.from(state);
    return state;
  }

  void initWithLoan(Loan loan) {
    state = <String, int>{};
    for (var itemQty in loan.itemsQuantity) {
      state[itemQty.itemSimple.id] = itemQty.quantity;
    }
    state = Map.from(state);
  }

  void clear() {
    state.forEach((id, _) => state[id] = 0);
    state = Map.from(state);
  }
}

final selectedItemQuantitiesMapProvider =
    StateNotifierProvider<ItemQuantitiesMapNotifier, Map<String, int>>((ref) {
  return ItemQuantitiesMapNotifier();
});

final loanItemQuantitiesMapProvider =
    StateNotifierProvider<ItemQuantitiesMapNotifier, Map<String, int>>((ref) {
  final loan = ref.watch(loanProvider);

  ItemQuantitiesMapNotifier itemQuantitiesMapNotifier =
      ItemQuantitiesMapNotifier();
  itemQuantitiesMapNotifier.initWithLoan(loan);

  return itemQuantitiesMapNotifier;
});
