import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<bool>>((ref) {
  final productsList = ref.watch(itemListProvider);
  final products = [];
  productsList.when(
    data: (list) => products.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  return SelectedListProvider(products);
});

final editSelectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<bool>>((ref) {
  final loan = ref.watch(loanProvider);
  final productsList = ref.watch(itemListProvider);
  final List<Item> products = [];
  productsList.when(
    data: (list) => products.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  SelectedListProvider _selectedListProvider = SelectedListProvider(products);
  _selectedListProvider.initWithLoan(products, loan);
  return _selectedListProvider;
});

class SelectedListProvider extends StateNotifier<List<bool>> {
  SelectedListProvider(List<dynamic> p)
      : super(List.generate(p.length, (index) => false));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }

  void initWithLoan(List<Item> products, Loan loan) {
    var copy = state.toList();
    final productIds = products.map((i) => i.id).toList();
    for (var item in loan.items) {
      if (productIds.contains(item.id)) {
        copy[productIds.indexOf(item.id)] = true;
      }
    }
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => false);
  }
}
