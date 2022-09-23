import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/dialog.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class ItemUi extends HookConsumerWidget {
  final Item l;
  final Loaner loaner;
  const ItemUi({Key? key, required this.l, required this.loaner})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final itemList = ref.watch(itemListProvider.notifier);
    final itemNotifier = ref.watch(itemProvider.notifier);
    void displayLoanToastWithContext(TypeMsg type, String msg) {
      displayLoanToast(context, type, msg);
    }

    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
            ),
            Expanded(
              child: Text(
                l.name,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 15,
                ),
                Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${l.caution}€",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        LoanColorConstants.lightOrange,
                        LoanColorConstants.orange
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: LoanColorConstants.orange.withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.pencilSquare,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    itemList.setId(loaner.id);
                    itemNotifier.setItem(l);
                    pageNotifier.setLoanPage(LoanPage.editItem);
                  },
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        LoanColorConstants.lightGrey,
                        LoanColorConstants.darkGrey
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: LoanColorConstants.darkGrey.withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.trash,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => LoanDialog(
                            descriptions: LoanTextConstants.deletingItem,
                            title: LoanTextConstants.deleting,
                            onYes: () async {
                              tokenExpireWrapper(ref, () async {
                                itemListNotifier.setId(loaner.id);
                                final value =
                                    await itemListNotifier.deleteItem(l);
                                if (value) {
                                  final value = await itemListNotifier.copy();
                                  await loanersitemsNotifier.setTData(
                                      loaner, value);
                                  displayLoanToastWithContext(TypeMsg.msg,
                                      LoanTextConstants.deletedItem);
                                } else {
                                  displayLoanToastWithContext(TypeMsg.error,
                                      LoanTextConstants.deletingError);
                                }
                              });
                            }));
                  },
                )
              ],
            ),
            Container(
              width: 15,
            ),
          ],
        ));
  }
}
