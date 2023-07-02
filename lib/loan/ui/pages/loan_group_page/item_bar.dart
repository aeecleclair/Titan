import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';

class ItemBar extends HookConsumerWidget {
  final bool isEdit;
  const ItemBar({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanersItems = ref.watch(loanersItemsProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    final endNotifier = ref.watch(endProvider.notifier);
    final start = ref.watch(startProvider);
    final itemListForSelected = ref.watch(itemListProvider);
    final cautionNotifier = ref.watch(cautionProvider.notifier);
    return itemListForSelected.when(data: (data) {
      final sortedAvailableData = data
          .where((element) => element.loanedQuantity < element.totalQuantity)
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      final sortedUnavailableData = data
          .where((element) => element.loanedQuantity >= element.totalQuantity)
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      data = sortedAvailableData + sortedUnavailableData;
      return loanersItems.when(data: (items) {
        if (items[loaner] != null) {
          return items[loaner]!.when(data: (itemList) {
            if (itemList.isNotEmpty) {
              final sortedAvailable = itemList
                  .where((element) =>
                      element.loanedQuantity < element.totalQuantity)
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));
              final sortedUnavailable = itemList
                  .where((element) =>
                      element.loanedQuantity >= element.totalQuantity)
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));
              itemList = sortedAvailable + sortedUnavailable;
              return HorizontalListView(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        ...itemList.map((e) {
                          var currentValue = selectedItems[data.indexOf(e)];
                          return Column(
                            children: [
                              CheckItemCard(
                                item: e,
                                isSelected: currentValue != 0,
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: GestureDetector(
                                        child: HeroIcon(
                                          HeroIcons.minus,
                                          color: currentValue == 0
                                              ? Colors.grey.shade400
                                              : Colors.white,
                                        ),
                                        onTap: () {
                                          if (currentValue > 0) {
                                            selectedItemsNotifier.set(
                                                data.indexOf(e),
                                                currentValue - 1);
                                            Map<Item, int>
                                                selectedItemsWithQuantity =
                                                Map.fromIterables(
                                                    data, selectedItems);
                                            selectedItemsWithQuantity[e] =
                                                currentValue - 1;
                                            List<Item> selected =
                                                selectedItemsWithQuantity.keys
                                                    .where((element) =>
                                                        selectedItemsWithQuantity[
                                                            element] !=
                                                        0)
                                                    .toList();
                                            if (selected.isNotEmpty) {
                                              endNotifier.setEndFromSelected(
                                                  start, selected);
                                              cautionNotifier
                                                  .setCautionFromSelected(
                                                      selectedItemsWithQuantity);
                                            } else {
                                              endNotifier.setEnd("");
                                              cautionNotifier.setCaution("");
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Text(
                                        currentValue.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: currentValue == 0
                                              ? Colors.grey.shade400
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GestureDetector(
                                          child: HeroIcon(
                                            HeroIcons.plus,
                                            color: currentValue ==
                                                    e.totalQuantity -
                                                        e.loanedQuantity
                                                ? Colors.grey.shade400
                                                : Colors.white,
                                          ),
                                          onTap: () {
                                            if (currentValue <
                                                e.totalQuantity -
                                                    e.loanedQuantity) {
                                              selectedItemsNotifier.set(
                                                  data.indexOf(e),
                                                  currentValue + 1);
                                              Map<Item, int>
                                                  selectedItemsWithQuantity =
                                                  Map.fromIterables(
                                                      data, selectedItems);
                                              selectedItemsWithQuantity[e] =
                                                  currentValue + 1;
                                              List<Item> selected =
                                                  selectedItemsWithQuantity.keys
                                                      .where((element) =>
                                                          selectedItemsWithQuantity[
                                                              element] !=
                                                          0)
                                                      .toList();
                                              if (selected.isNotEmpty) {
                                                endNotifier.setEndFromSelected(
                                                    start, selected);
                                                cautionNotifier
                                                    .setCautionFromSelected(
                                                        selectedItemsWithQuantity);
                                              } else {
                                                endNotifier.setEnd("");
                                                cautionNotifier.setCaution("");
                                              }
                                            }
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(width: 15),
                      ]));
            } else {
              return const SizedBox(
                height: 198,
                child: Center(
                    child: Text(LoanTextConstants.noItems,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              );
            }
          }, error: (error, s) {
            return SizedBox(
              height: 160,
              child: Text(error.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
            );
          }, loading: () {
            return const SizedBox(
              height: 160,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ColorConstants.background2)),
            );
          });
        } else {
          return const SizedBox(
            height: 160,
            child: Center(
                child: Text(LoanTextConstants.noItems,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
          );
        }
      }, error: (Object error, StackTrace stackTrace) {
        return const SizedBox(
          height: 160,
          child: Center(
              child: Text(LoanTextConstants.noItems,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        );
      }, loading: () {
        return const SizedBox(
          height: 160,
          child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.background2)),
        );
      });
    }, error: (Object error, StackTrace stackTrace) {
      return const SizedBox(
        height: 160,
        child: Center(
            child: Text(LoanTextConstants.noItems,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
      );
    }, loading: () {
      return const SizedBox(
        height: 160,
        child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.background2)),
      );
    });
  }
}
