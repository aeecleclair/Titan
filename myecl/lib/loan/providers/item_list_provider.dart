import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class ItemListNotifier extends ListProvider<Item> {
  final ItemRepository _itemrepository = ItemRepository();
  late final String loanerId;
  ItemListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _itemrepository.setToken(token);
  }

  void setId(String id) {
    loanerId = id;
  }

  Future<AsyncValue<List<Item>>> loadLoanList() async {
    return await loadList(() async {
      return await _itemrepository.getItemList(loanerId);
    });
  }

  Future<bool> addItem(Item item) async {
    return await add((i) async {
      return await _itemrepository.createItem(loanerId, i);
    }, item);
  }

  Future<bool> updateItem(Item item) async {
    return await update((i) async {
      return await _itemrepository.updateItem(loanerId, i);
    }, (items, item) {
      final loanersId = items.map((e) => e.id).toList();
      final index = loanersId.indexOf(item.id);
      items[index] = item;
      return items;
    }, item);
  }

  Future<bool> deleteItem(Item item) async {
    return await delete((id) async {
      return await _itemrepository.deleteItem(loanerId, id);
    }, item.id, item);
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loanerId = ref.watch(loanerIdProvider);
  ItemListNotifier _itemListNotifier = ItemListNotifier(token: token);
  _itemListNotifier.setId(loanerId);
  _itemListNotifier.loadLoanList();
  return _itemListNotifier;
});
