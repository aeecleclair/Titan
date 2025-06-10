import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/caution_provider.dart';
import 'package:titan/loan/providers/end_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/providers/selected_items_provider.dart';
import 'package:titan/loan/providers/start_provider.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

class ItemBar extends HookConsumerWidget {
  final bool isEdit;
  const ItemBar({super.key, required this.isEdit});

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
    return SizedBox(
      height: 180,
      child: AsyncChild(
        value: itemListForSelected,
        loaderColor: ColorConstants.background2,
        builder: (context, data) {
          if (loanersItems[loaner] == null) {
            return const SizedBox(
              height: 180,
              child: Center(
                child: Text(
                  LoanTextConstants.noItems,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }
          return AsyncChild(
            value: loanersItems[loaner]!,
            loaderColor: ColorConstants.background2,
            builder: (context, itemList) {
              if (itemList.isEmpty) {
                return const SizedBox(
                  height: 180,
                  child: Center(
                    child: Text(
                      LoanTextConstants.noItems,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }
              return HorizontalListView.builder(
                height: 180,
                items: itemList,
                itemBuilder: (context, e, i) {
                  var currentValue = selectedItems[data.indexOf(e)];
                  return Column(
                    children: [
                      CheckItemCard(item: e, isSelected: currentValue != 0),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      currentValue - 1,
                                    );
                                    Map<Item, int> selectedItemsWithQuantity =
                                        Map.fromIterables(data, selectedItems);
                                    selectedItemsWithQuantity[e] =
                                        currentValue - 1;
                                    List<Item>
                                    selected = selectedItemsWithQuantity.keys
                                        .where(
                                          (element) =>
                                              selectedItemsWithQuantity[element] !=
                                              0,
                                        )
                                        .toList();
                                    if (selected.isNotEmpty) {
                                      endNotifier.setEndFromSelected(
                                        start,
                                        selected,
                                      );
                                      cautionNotifier.setCautionFromSelected(
                                        selectedItemsWithQuantity,
                                      );
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
                                horizontal: 6,
                              ),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                child: HeroIcon(
                                  HeroIcons.plus,
                                  color:
                                      currentValue ==
                                          e.totalQuantity - e.loanedQuantity
                                      ? Colors.grey.shade400
                                      : Colors.white,
                                ),
                                onTap: () {
                                  if (currentValue <
                                      e.totalQuantity - e.loanedQuantity) {
                                    selectedItemsNotifier.set(
                                      data.indexOf(e),
                                      currentValue + 1,
                                    );
                                    Map<Item, int> selectedItemsWithQuantity =
                                        Map.fromIterables(data, selectedItems);
                                    selectedItemsWithQuantity[e] =
                                        currentValue + 1;
                                    List<Item>
                                    selected = selectedItemsWithQuantity.keys
                                        .where(
                                          (element) =>
                                              selectedItemsWithQuantity[element] !=
                                              0,
                                        )
                                        .toList();
                                    if (selected.isNotEmpty) {
                                      endNotifier.setEndFromSelected(
                                        start,
                                        selected,
                                      );
                                      cautionNotifier.setCautionFromSelected(
                                        selectedItemsWithQuantity,
                                      );
                                    } else {
                                      endNotifier.setEnd("");
                                      cautionNotifier.setCaution("");
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
