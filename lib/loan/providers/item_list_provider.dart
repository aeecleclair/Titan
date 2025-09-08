import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/loaner_id_provider.dart';
import 'package:titan/loan/repositories/item_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ItemListNotifier extends ListNotifier<Item> {
  final ItemRepository itemrepository;
  ItemListNotifier({required this.itemrepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadItemList(String id) async {
    return await loadList(() async => itemrepository.getItemList(id));
  }

  Future<bool> addItem(Item item, String loanerId) async {
    return await add((i) async => itemrepository.createItem(loanerId, i), item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
      (i) async => itemrepository.updateItem(loanerId, i),
      (items, item) => items..[items.indexWhere((i) => i.id == item.id)] = item,
      item,
    );
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
      (id) async => itemrepository.deleteItem(loanerId, id),
      (items, item) => items..removeWhere((i) => i.id == item.id),
      item.id,
      item,
    );
  }

  Future<AsyncValue<List<Item>>> copy() async {
    return state.whenData((d) => d.sublist(0));
  }

  Future<AsyncValue<List<Item>>> filterItems(String query) async {
    return state.whenData(
      (items) => items
          .where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList(),
    );
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
      final itemRepository = ref.watch(itemRepositoryProvider);
      ItemListNotifier itemListNotifier = ItemListNotifier(
        itemrepository: itemRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        final loanerId = ref.watch(loanerIdProvider);
        if (loanerId != "") {
          await itemListNotifier.loadItemList(loanerId);
        }
      });
      return itemListNotifier;
    });
