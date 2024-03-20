import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_map_provider.dart';
import 'package:myecl/loan/providers/item_quantities_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';

class ItemBar extends HookConsumerWidget {
  final bool isEdit;
  const ItemBar({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoaner = ref.watch(selectedLoanerProvider);

    final selectedLoanerItems =
        ref.watch(loanersItemsMapProvider.select((map) => map[selectedLoaner]));
    final loanersItemsMapNotifier = ref.read(loanersItemsMapProvider.notifier);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanItemQuantities = ref.watch(loanItemQuantitiesMapProvider);
    final loanItemQuantitiesNotifier =
        ref.watch(loanItemQuantitiesMapProvider.notifier);

    final ValueNotifier<String> filterQuery = useState("");

    final endNotifier = ref.watch(endProvider.notifier);
    final start = ref.watch(startProvider);
    final cautionNotifier = ref.watch(cautionProvider.notifier);
    return Column(
      children: [
        StyledSearchBar(
          label:
              isEdit ? LoanTextConstants.editLoan : LoanTextConstants.addLoan,
          onChanged: (query) async {
            filterQuery.value = query;
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: AutoLoaderChild(
            group: selectedLoanerItems,
            notifier: loanersItemsMapNotifier,
            mapKey: selectedLoaner,
            listLoader: (loaner) {
              return itemListNotifier.loadItemList(loaner.id);
            },
            dataBuilder: (context, items) {
              if (items.isEmpty) {
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
              final sortedAvailableItems = items
                  .where(
                    (element) => element.loanedQuantity < element.totalQuantity,
                  )
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));
              final sortedUnavailableItems = items
                  .where(
                    (element) =>
                        element.loanedQuantity >= element.totalQuantity,
                  )
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));
              final sortedLoanerItems =
                  sortedAvailableItems + sortedUnavailableItems;
              return HorizontalListView.builder(
                height: 180,
                items: filteredItems(sortedLoanerItems, filterQuery.value),
                itemBuilder: (context, item, _) {
                  final currentValue = loanItemQuantities[item.id] ?? 0;
                  return Column(
                    children: [
                      CheckItemCard(
                        item: item,
                        isSelected: currentValue != 0,
                      ),
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
                                    loanItemQuantitiesNotifier.set(
                                      item.id,
                                      currentValue - 1,
                                    );
                                    List<Item> selected = items
                                        .where(
                                          (item) =>
                                              loanItemQuantities[item.id] !=
                                                  null &&
                                              loanItemQuantities[item.id]! > 0,
                                        )
                                        .toList();
                                    if (selected.isNotEmpty) {
                                      endNotifier.setEndFromSelected(
                                        start,
                                        selected,
                                      );
                                      cautionNotifier.setCautionFromSelected(
                                        {
                                          for (var item in items)
                                            item: loanItemQuantities[item.id] ??
                                                0,
                                        },
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
                                  color: currentValue ==
                                          item.totalQuantity -
                                              item.loanedQuantity
                                      ? Colors.grey.shade400
                                      : Colors.white,
                                ),
                                onTap: () {
                                  if (currentValue <
                                      item.totalQuantity -
                                          item.loanedQuantity) {
                                    loanItemQuantitiesNotifier.set(
                                      item.id,
                                      currentValue + 1,
                                    );
                                    List<Item> selected = items
                                        .where(
                                          (item) =>
                                              loanItemQuantities[item.id] !=
                                                  null &&
                                              loanItemQuantities[item.id]! > 0,
                                        )
                                        .toList();
                                    if (selected.isNotEmpty) {
                                      endNotifier.setEndFromSelected(
                                        start,
                                        selected,
                                      );
                                      cautionNotifier.setCautionFromSelected(
                                        {
                                          for (var item in items)
                                            item: loanItemQuantities[item.id] ??
                                                0,
                                        },
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
          ),
        ),
      ],
    );
  }
}
