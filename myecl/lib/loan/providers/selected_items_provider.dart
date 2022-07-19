import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final products = [];
  productsList.when(
    data: (list) => products.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  SelectedListProvider _selectedListProvider = SelectedListProvider(products);
  loan.when(
    data: (l) {
      _selectedListProvider.initWithLoan(l);
    },
    error: (e, s) {},
    loading: () {},
  );
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

  void initWithLoan(Loan loan) {
    var copy = state.toList();
    for (var item in loan.items) {
      copy[loan.items.indexOf(item)] = true;
    }
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => false);
  }
}
