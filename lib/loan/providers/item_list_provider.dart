import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ItemListNotifier extends ListNotifier<Item> {
  final ItemRepository _itemrepository = ItemRepository();
  ItemListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _itemrepository.setToken(token);
  }


  Future<AsyncValue<List<Item>>> loadItemList(String id) async {
    return await loadList(() async => _itemrepository.getItemList(id));
  }

  Future<bool> addItem(Item item, String loanerId) async {
    return await add(
        (i) async => _itemrepository.createItem(loanerId, i), item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
        (i) async => _itemrepository.updateItem(loanerId, i),
        (items, item) =>
            items..[items.indexWhere((i) => i.id == item.id)] = item,
        item);
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
        (id) async => _itemrepository.deleteItem(loanerId, id),
        (items, item) => items..removeWhere((i) => i.id == item.id),
        item.id,
        item);
  }

  Future<AsyncValue<List<Item>>> copy() async {
    return state.when(
        data: (d) => AsyncValue.data(d.sublist(0)),
        error: (e, s) => AsyncValue.error(e, s),
        loading: () => const AsyncValue.loading());
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final token = ref.watch(tokenProvider);
  ItemListNotifier itemListNotifier = ItemListNotifier(token: token);
  final loanerId = ref.watch(loanerIdProvider);
  if (loanerId != "") {
    itemListNotifier.loadItemList(loanerId);
  }
  return itemListNotifier;
});
