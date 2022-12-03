import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/item_card.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LoanersItems extends HookConsumerWidget {
  const LoanersItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
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
            data: (data) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      pageNotifier.setLoanPage(LoanPage.addItem);
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
                              color: Colors.grey.shade200.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade200.withOpacity(0.5),
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
                                        final value = await itemListNotifier
                                            .deleteItem(e);
                                        if (value) {
                                          await loanersitemsNotifier.setTData(
                                              loaner,
                                              await itemListNotifier.copy());
                                          displayToastWithContext(TypeMsg.msg,
                                              LoanTextConstants.deletedItem);
                                        } else {
                                          displayToastWithContext(TypeMsg.error,
                                              LoanTextConstants.deletingError);
                                        }
                                      });
                                    },
                                    title: LoanTextConstants.delete);
                              });
                        },
                        onEdit: () {
                          pageNotifier.setLoanPage(LoanPage.editItem);
                          itemNotifier.setItem(e);
                        },
                      )),
                  const SizedBox(width: 10),
                ],
              ),
            ),
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
            child: Text('No items'),
          );
        }
      },
      error: (Object error, StackTrace? stackTrace) {
        return const Center(child: Text('Error'));
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
