import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/ui/loaner_chip.dart';
import 'package:myecl/tools/functions.dart';

class LoanersBar extends HookConsumerWidget {
  const LoanersBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    final loanerIdNotifier = ref.watch(loanerIdProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    return adminLoanList.when(
      data: (loans) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            ...loans
                .map((key, value) => MapEntry(
                    LoanerChip(
                      label: capitalize(key.name),
                      selected: loaner.id == key.id,
                      onTap: () async {
                        loanerIdNotifier.setId(key.id);
                        loanersItems.whenData(
                          (value) async {
                            if (value[key] != null) {
                              value[key]!.whenData((value) async {
                                if (value.isEmpty) {
                                  itemListNotifier.loadItemList(key.id);
                                  loanersitemsNotifier.setTData(
                                      key, await itemListNotifier.copy());
                                }
                              });
                            } else {
                              itemListNotifier.loadItemList(key.id);
                              loanersitemsNotifier.setTData(
                                  key, await itemListNotifier.copy());
                            }
                          },
                        );
                        adminLoanList.whenData(
                          (value) async {
                            if (value[key] != null) {
                              value[key]!.whenData((value) async {
                                if (value.isEmpty) {
                                  loanListNotifier.loadLoan(key.id);
                                  adminLoanListNotifier.setTData(
                                      key, await loanListNotifier.copy());
                                }
                              });
                            } else {
                              loanListNotifier.loadLoan(key.id);
                              adminLoanListNotifier.setTData(
                                  key, await loanListNotifier.copy());
                            }
                          },
                        );
                      },
                    ),
                    value))
                .keys,
            const SizedBox(width: 15),
          ],
        ),
      ),
      error: (Object error, StackTrace stackTrace) {
        return const Center(
          child: Text('Something went wrong'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
