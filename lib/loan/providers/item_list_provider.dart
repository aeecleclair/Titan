import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ItemListNotifier extends ListNotifier<Item> {
  final ItemRepository itemRepository = ItemRepository();
  ItemListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    itemRepository.setToken(token);
  }


  Future<AsyncValue<List<Item>>> loadItemList(String id) async {
    return await loadList(() async => itemRepository.getItemList(id));
  }

  Future<bool> addItem(Item item, String loanerId) async {
    return await add(
        (i) async => itemRepository.createItem(loanerId, i), item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
        (i) async => itemRepository.updateItem(loanerId, i),
        (items, item) =>
            items..[items.indexWhere((i) => i.id == item.id)] = item,
        item);
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
        (id) async => itemRepository.deleteItem(loanerId, id),
        (items, item) => items..removeWhere((i) => i.id == item.id),
        item.id,
        item);
  }

  Future<AsyncValue<List<Item>>> copy() async {
    return state.whenData((d) => d.sublist(0));
  }

  Future<AsyncValue<List<Item>>> filterItems(String query) async {
    return state.whenData((items) => items
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final token = ref.watch(tokenProvider);
  ItemListNotifier itemListNotifier = ItemListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      await itemListNotifier.loadItemList(loanerId);
    }
  });
  return itemListNotifier;
});
