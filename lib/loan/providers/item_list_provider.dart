import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ItemListNotifier extends ListNotifier<Item> {
  final ItemRepository _itemrepository = ItemRepository();
  String loanerId = "";
  ItemListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _itemrepository.setToken(token);
  }

  void setId(String id) {
    loanerId = id;
  }

  Future<AsyncValue<List<Item>>> loadItemList() async {
    return await loadList(() async => _itemrepository.getItemList(loanerId));
  }

  Future<bool> addItem(Item item) async {
    return await add(
        (i) async => _itemrepository.createItem(loanerId, i), item);
  }

  Future<bool> updateItem(Item item) async {
    return await update(
        (i) async => _itemrepository.updateItem(loanerId, i),
        (items, item) =>
            items..[items.indexWhere((i) => i.id == item.id)] = item,
        item);
  }

  Future<bool> deleteItem(Item item) async {
    return await delete(
        (id) async => _itemrepository.deleteItem(loanerId, id),
        (items, item) => items..removeWhere((i) => i.id == item.id),
        item.id,
        item);
  }

  Future<AsyncValue<List<Item>>> copy() {
    return state.when(
        data: (d) async => AsyncValue.data(d.sublist(0)),
        error: (e, s) async => AsyncValue.error(e),
        loading: () async => const AsyncValue.loading());
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loanerId = ref.watch(loanerIdProvider);
  ItemListNotifier itemListNotifier = ItemListNotifier(token: token);
  itemListNotifier.setId(loanerId);
  itemListNotifier.loadItemList();
  return itemListNotifier;
});
