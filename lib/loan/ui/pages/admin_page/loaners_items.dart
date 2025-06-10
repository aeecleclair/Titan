import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/item_focus_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/item_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/loan/ui/pages/admin_page/item_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanersItems extends HookConsumerWidget {
  const LoanersItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanersItemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final itemList = ref.watch(itemListProvider);
    final itemNotifier = ref.watch(itemProvider.notifier);
    final focus = ref.watch(itemFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final item = loanersItems[loaner];
    if (item == null) {
      return const Center(child: Text(LoanTextConstants.noItems));
    }
    return AsyncChild(
      value: item,
      builder: (context, data) {
        if (data.isNotEmpty) {
          data.sort((a, b) => a.name.compareTo(b.name));
        }
        return Column(
          children: [
            StyledSearchBar(
              label: LoanTextConstants.itemHandling,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  loanersItemsNotifier.setTData(
                    loaner,
                    await itemListNotifier.filterItems(value),
                  );
                } else {
                  loanersItemsNotifier.setTData(loaner, itemList);
                }
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
              items: data,
              itemBuilder: (context, e, i) => ItemCard(
                item: e,
                showButtons: true,
                onDelete: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        descriptions: LoanTextConstants.deletingItem,
                        onYes: () {
                          tokenExpireWrapper(ref, () async {
                            final value = await itemListNotifier.deleteItem(
                              e,
                              loaner.id,
                            );
                            if (value) {
                              itemListNotifier.copy().then((value) {
                                loanersItemsNotifier.setTData(loaner, value);
                              });
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
                  itemNotifier.setItem(e);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
