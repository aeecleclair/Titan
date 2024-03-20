import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class LoanersItemsMapNotifier extends MapNotifier<Loaner, Item> {
  LoanersItemsMapNotifier() : super();

  void addItemForLoaner(
    Loaner loaner,
    Item item,
  ) {
    return state[loaner]!.maybeWhen(
      data: (itemList) {
        itemList.add(item);
        state[loaner] = AsyncValue.data(itemList);
        state = Map.from(state);
      },
      orElse: () {},
    );
  }

  void updateItemForLoaner(
    Loaner loaner,
    Item item,
  ) {
    return state[loaner]!.maybeWhen(
      data: (itemList) {
        itemList[itemList
            .indexWhere((itemToTest) => item.id == itemToTest.id)] = item;
        state[loaner] = AsyncValue.data(itemList);
        state = Map.from(state);
      },
      orElse: () {},
    );
  }

  void updateItemsFromLoanReturnForLoaner(
    Loaner loaner,
    List<ItemQuantity> itemQuantities,
  ) {
    return state[loaner]!.maybeWhen(
      data: (itemList) {
        for (var itemQuantity in itemQuantities) {
          int itemIndex = itemList
              .indexWhere((item) => item.id == itemQuantity.itemSimple.id);
          itemList[itemIndex] = itemList[itemIndex].copyWith(
              loanedQuantity:
                  itemList[itemIndex].loanedQuantity - itemQuantity.quantity);
        }
        state[loaner] = AsyncValue.data(itemList);
        state = Map.from(state);
      },
      orElse: () {},
    );
  }

  void removeItemForLoaner(Loaner loaner, Item item) {
    return state[loaner]!.maybeWhen(
      data: (itemList) {
        itemList.removeWhere(
          (itemToTest) => itemToTest.id == item.id,
        );
        state[loaner] = AsyncValue.data(itemList);
        state = Map.from(state);
      },
      orElse: () {},
    );
  }
}

final loanersItemsMapProvider = StateNotifierProvider<LoanersItemsMapNotifier,
    Map<Loaner, AsyncValue<List<Item>>?>>((ref) {
  final loaners = ref.watch(userLoanerList);
  LoanersItemsMapNotifier loanerLoanListNotifier = LoanersItemsMapNotifier();
  loanerLoanListNotifier.loadTList(loaners);
  return loanerLoanListNotifier;
});
