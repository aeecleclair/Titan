import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/loan/providers/loaner_id_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ItemListNotifier extends ListNotifierAPI<Item> {
  Openapi get itemRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Item>> build() {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      loadItemList(loanerId);
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Item>>> loadItemList(String loanerId) async {
    return await loadList(
      () async =>
          itemRepository.loansLoanersLoanerIdItemsGet(loanerId: loanerId),
    );
  }

  Future<bool> addItem(ItemBase item, String loanerId) async {
    return await add(
      () async => itemRepository.loansLoanersLoanerIdItemsPost(
        loanerId: loanerId,
        body: item,
      ),
      item,
    );
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
      () async => itemRepository.loansLoanersLoanerIdItemsItemIdPatch(
        loanerId: loanerId,
        itemId: item.id,
        body: ItemUpdate(
          name: item.name,
          suggestedCaution: item.suggestedCaution,
          totalQuantity: item.totalQuantity,
          suggestedLendingDuration: item.suggestedLendingDuration,
        ),
      ),
      (item) => item.id,
      item,
    );
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
      () async => itemRepository.loansLoanersLoanerIdItemsItemIdDelete(
        loanerId: loanerId,
        itemId: item.id,
      ),
      (item) => item.id,
      item.id,
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
    NotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>(
      ItemListNotifier.new,
    );
