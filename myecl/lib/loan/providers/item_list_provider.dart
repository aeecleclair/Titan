import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class ItemListNotifier extends ListProvider<Item> {
  final ItemRepository _itemrepository = ItemRepository();
  ItemListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _itemrepository.setToken(token);
  }

  Future<AsyncValue<List<Item>>> loadLoanList() async {
    return await loadList(_itemrepository.getItemList);
  }

  Future<bool> addItem(Item item) async {
    return await add(_itemrepository.createItem, item);
  }

  Future<bool> updateItem(Item item) async {
    return await update(_itemrepository.updateItem, item);
  }

  Future<bool> deleteItem(Item item) async {
    return await delete(_itemrepository.deleteItem, item.id, item);
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final token = ref.watch(tokenProvider);
  ItemListNotifier _itemListNotifier = ItemListNotifier(token: token);
  _itemListNotifier.loadLoanList();
  return _itemListNotifier;
});
