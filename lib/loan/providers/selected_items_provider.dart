import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<int>>((ref) {
  final itemsList = ref.watch(itemListProvider);
  final items = [];
  itemsList.when(
    data: (list) => items.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  return SelectedListProvider(items);
});

final editSelectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<int>>((ref) {
  final loan = ref.watch(loanProvider);
  final itemsList = ref.watch(itemListProvider);
  final List<Item> items = [];
  itemsList.when(
    data: (list) => items.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  SelectedListProvider selectedListProvider = SelectedListProvider(items);
  selectedListProvider.initWithLoan(items, loan);
  return selectedListProvider;
});

class SelectedListProvider extends StateNotifier<List<int>> {
  SelectedListProvider(List<dynamic> p)
      : super(List.generate(p.length, (index) => 0));

  Future<List<int>> toggle(int i, int quantity) async {
    var copy = state.toList();
    copy[i] = copy[i] == -1 ? quantity : -1;
    state = copy;
    return state;
  }

  Future<List<int>> set(int i, int quantity) async {
    var copy = state.toList();
    copy[i] = quantity;
    state = copy;
    return state;
  }

  void initWithLoan(List<Item> items, Loan loan) {
    var copy = state.toList();
    final itemIds = items.map((i) => i.id).toList();
    for (var itemQty in loan.itemsQuantity) {
      if (itemIds.contains(itemQty.item.id)) {
        copy[itemIds.indexOf(itemQty.item.id)] = itemQty.quantity;
      }
    }
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => 0);
  }
}
