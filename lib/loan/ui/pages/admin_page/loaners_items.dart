import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/item_card.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/web_list_view.dart';

class LoanersItems extends HookConsumerWidget {
  const LoanersItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final itemNotifier = ref.watch(itemProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return loanersItems.when(
      data: (items) {
        if (items[loaner] != null) {
          return items[loaner]!.when(
            data: (data) {
              if (data.isNotEmpty) {
                data.sort((a, b) => a.name.compareTo(b.name));
              }
              return SizedBox(
                  height: 170,
                  child: WebListView(
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            itemNotifier.setItem(Item.empty());
                            pageNotifier.setLoanPage(LoanPage.addEditItem);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: 120,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: HeroIcon(
                                  HeroIcons.plus,
                                  size: 40.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...data.map((e) => ItemCard(
                              item: e,
                              showButtons: true,
                              onDelete: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                          descriptions:
                                              LoanTextConstants.deletingItem,
                                          onYes: () {
                                            tokenExpireWrapper(ref, () async {
                                              final value =
                                                  await itemListNotifier
                                                      .deleteItem(e, loaner.id);
                                              if (value) {
                                                itemListNotifier
                                                    .copy()
                                                    .then((value) {
                                                  loanersitemsNotifier.setTData(
                                                      loaner, value);
                                                });
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    LoanTextConstants
                                                        .deletedItem);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    LoanTextConstants
                                                        .deletingError);
                                              }
                                            });
                                          },
                                          title: LoanTextConstants.delete);
                                    });
                              },
                              onEdit: () {
                                pageNotifier.setLoanPage(LoanPage.addEditItem);
                                itemNotifier.setItem(e);
                              },
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ));
            },
            error: (Object error, StackTrace? stackTrace) {
              return Center(child: Text('Error $error'));
            },
            loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          );
        } else {
          return const Center(
            child: Text(LoanTextConstants.noItems),
          );
        }
      },
      error: (Object error, StackTrace? stackTrace) {
        return Center(child: Text('Error $error'));
      },
      loading: () {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    );
  }
}
