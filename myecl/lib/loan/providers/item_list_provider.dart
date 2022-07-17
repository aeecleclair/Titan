import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/repositories/item_repository.dart';

class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final ItemRepository _repository = ItemRepository();
  ItemListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadLoanList() async {
    try {
      final items = await _repository.getItemList();
      state = AsyncValue.data(items);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addLoan(Item item) async {
    return state.when(
      data: (items) async {
        try {
          await _repository.createItem(item);
          items.add(item);
          state = AsyncValue.data(items);
          return true;
        } catch (e) {
          state = AsyncValue.data(items);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add loan while loading");
        return false;
      },
    );
  }

  Future<bool> updateLoan(Item item) async {
    return state.when(
      data: (items) async {
        try {
          await _repository.updateItem(item);
          var index = items.indexWhere((element) => element.id == item.id);
          items[index] = item;
          state = AsyncValue.data(items);
          return true;
        } catch (e) {
          state = AsyncValue.data(items);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update loan while loading");
        return false;
      },
    );
  }

  Future<bool> deleteLoan(Item item) async {
    return state.when(
      data: (items) async {
        try {
          await _repository.deleteItem(item);
          items.remove(item);
          state = AsyncValue.data(items);
          return true;
        } catch (e) {
          state = AsyncValue.data(items);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete loan while loading");
        return false;
      },
    );
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  ItemListNotifier _itemListNotifier = ItemListNotifier();
  _itemListNotifier.loadLoanList();
  return _itemListNotifier;
});
