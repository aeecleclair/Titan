import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';

class EditSelectedListProvider extends Notifier<List<int>> {
  @override
  List<int> build() {
    final loan = ref.watch(loanProvider);
    final itemsList = ref.watch(itemListProvider);
    final List<Item> items = [];
    itemsList.maybeWhen(data: (list) => items.addAll(list), orElse: () {});

    final result = List.generate(items.length, (index) => 0);
    final itemIds = items.map((item) => item.id).toList();

    for (final itemQty in loan.itemsQty) {
      final index = itemIds.indexOf(itemQty.itemSimple.id);
      if (index != -1) {
        result[index] = itemQty.quantity;
      }
    }

    return result;
  }

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

  void clear() {
    state = List.generate(state.length, (index) => 0);
  }
}

final editSelectedListProvider =
    NotifierProvider<EditSelectedListProvider, List<int>>(
      EditSelectedListProvider.new,
    );
