import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/item_focus_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_map_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/admin_page/item_card.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanersItems extends HookConsumerWidget {
  const LoanersItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoaner = ref.watch(selectedLoanerProvider);

    final selectedLoanerItems = ref
        .watch(loanersItemsMapProvider.select((map) => map[selectedLoaner.id]));
    final loanersItemsMapNotifier = ref.read(loanersItemsMapProvider.notifier);
    final itemListNotifier = ref.read(itemListProvider.notifier);

    final itemNotifier = ref.read(itemProvider.notifier);

    final ValueNotifier<String> filterQuery = useState("");

    final focus = ref.watch(itemFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AutoLoaderChild(
      group: selectedLoanerItems,
      notifier: loanersItemsMapNotifier,
      mapKey: selectedLoaner.id,
      listLoader: (loanerId) async {
        return itemListNotifier.loadItemList(loanerId);
      },
      dataBuilder: (context, items) {
        if (items.isEmpty) {
          return const Center(
            child: Text(LoanTextConstants.noItems),
          );
        }
        items.sort((a, b) => a.name.compareTo(b.name));
        return Column(
          children: [
            StyledSearchBar(
              label: LoanTextConstants.itemHandling,
              onChanged: (query) async {
                filterQuery.value = query;
              },
            ),
            const SizedBox(height: 10),
            HorizontalListView.builder(
              height: 150,
              firstChild: GestureDetector(
                onTap: () {
                  itemNotifier.setItem(Item.empty());
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditItem,
                  );
                },
                child: const CardLayout(
                  width: 100,
                  height: 140,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              items: filteredItems(items, filterQuery.value),
              itemBuilder: (context, item, _) => ItemCard(
                item: item,
                showButtons: true,
                onDelete: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        descriptions: LoanTextConstants.deletingItem,
                        onYes: () {
                          tokenExpireWrapper(ref, () async {
                            final isItemDeleted = await itemListNotifier
                                .deleteItem(item, selectedLoaner.id);
                            if (isItemDeleted) {
                              loanersItemsMapNotifier.removeItemForLoaner(
                                selectedLoaner,
                                item,
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                LoanTextConstants.deletedItem,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                LoanTextConstants.deletingError,
                              );
                            }
                          });
                        },
                        title: LoanTextConstants.delete,
                      );
                    },
                  );
                },
                onEdit: () {
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditItem,
                  );
                  itemNotifier.setItem(item);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
