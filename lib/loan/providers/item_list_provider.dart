import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ItemListNotifier extends ListNotifier<Item> {
  final ItemRepository itemRepository;
  ItemListNotifier({required this.itemRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadItemList(String loanerId) async {
    return await loadList(() async => itemRepository.getItemList(loanerId));
  }

  Future<bool> addItem(Item item, String loanerId) async {
    return await add((i) async => itemRepository.createItem(loanerId, i), item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
      (i) async => itemRepository.updateItem(loanerId, i),
      (items, item) => items..[items.indexWhere((i) => i.id == item.id)] = item,
      item,
    );
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
      (id) async => itemRepository.deleteItem(loanerId, id),
      (items, item) => items..removeWhere((i) => i.id == item.id),
      item.id,
      item,
    );
  }
}

//The provider give access to the notifier but should not be use directly as the state may be modified for any loaner at any time. Access items from loanersItemsMapProvider instead.
final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final itemRepository = ref.watch(itemRepositoryProvider);
  return ItemListNotifier(itemRepository: itemRepository);
});
