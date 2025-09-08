import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<int>>((ref) {
      final itemsList = ref.watch(itemListProvider);
      final items = [];
      itemsList.maybeWhen(data: (list) => items.addAll(list), orElse: () {});
      return SelectedListProvider(items);
    });

final editSelectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<int>>((ref) {
      final loan = ref.watch(loanProvider);
      final itemsList = ref.watch(itemListProvider);
      final List<Item> items = [];
      itemsList.maybeWhen(data: (list) => items.addAll(list), orElse: () {});
      SelectedListProvider selectedListProvider = SelectedListProvider(items);
      selectedListProvider.initWithLoan(items, loan);
      return selectedListProvider;
    });

class SelectedListProvider extends StateNotifier<List<int>> {
  SelectedListProvider(List<dynamic> p)
    : super(List.generate(p.length, (index) => 0));

  Future<List<int>> toggle(int i, int quantity) async {
    var copy = state.toList();
    copy[i] = copy[i] == 0 ? quantity : 0;
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
      if (itemIds.contains(itemQty.itemSimple.id)) {
        copy[itemIds.indexOf(itemQty.itemSimple.id)] = itemQty.quantity;
      }
    }
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => 0);
  }
}
