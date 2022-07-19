import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/repositories/item_repository.dart';

class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final ItemRepository _repository = ItemRepository();
  ItemListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadLoanList() async {
    try {
      // final items = await _repository.getItemList();
      final items = [
        Item(
          id: '1',
          name: 'Item 1',
          caution: 20,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '2',
          name: 'Item 2',
          caution: 80,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '3',
          name: 'Item 3',
          caution: 20,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '4',
          name: 'Item 4',
          caution: 20,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '5',
          name: 'Item 5',
          caution: 80,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '6',
          name: 'Item 6',
          caution: 20,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '7',
          name: 'Item 7',
          caution: 20,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
        Item(
          id: '8',
          name: 'Item 8',
          caution: 80,
          expiration: DateTime(2020, 1, 31),
          groupId: '',
        ),
      ];
      state = AsyncValue.data(items);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addItem(Item item) async {
    return state.when(
      data: (items) async {
        try {
          // await _repository.createItem(item);
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

  Future<bool> updateItem(Item item) async {
    return state.when(
      data: (items) async {
        try {
          // await _repository.updateItem(item);
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

  Future<bool> deleteItem(Item item) async {
    return state.when(
      data: (items) async {
        try {
          // await _repository.deleteItem(item);
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
