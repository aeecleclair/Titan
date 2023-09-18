import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_history_loan_list_provider.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/ui/loan.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_history.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_bar.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_items.dart';
import 'package:myecl/loan/ui/pages/admin_page/on_going_loan.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanerIdNotifier = ref.read(loanerIdProvider.notifier);
    final adminLoanList = ref.watch(adminLoanListProvider);
    final adminHistoryLoanList = ref.watch(adminHistoryLoanListProvider);
    final loanersItems = ref.watch(loanersItemsProvider);

    final opened = useState(false);

    if (!opened.value) {
      final loaner = ref.read(loanerProvider);
      final itemListNotifier = ref.read(itemListProvider.notifier);
      itemListNotifier.loadItemList(loaner.id).then((value) {
        ref.read(loanersItemsProvider.notifier).setTData(loaner, value);
      });
      opened.value = true;
    }

    return LoanTemplate(
      child: Refresher(
        onRefresh: () async {
          final itemListNotifier = ref.read(itemListProvider.notifier);
          final loanersItemsNotifier = ref.read(loanersItemsProvider.notifier);
          final loanListNotifier = ref.read(loanerLoanListProvider.notifier);
          final historyLoanListNotifier =
              ref.read(historyLoanerLoanListProvider.notifier);
          final adminLoanListNotifier =
              ref.read(adminLoanListProvider.notifier);
          final adminHistoryLoanListNotifier =
              ref.read(adminHistoryLoanListProvider.notifier);
          itemListNotifier.loadItemList(loaner.id);
          loanersItemsNotifier.setTData(loaner, await itemListNotifier.copy());
          loanListNotifier.loadLoan(loaner.id);
          adminLoanListNotifier.setTData(loaner, await loanListNotifier.copy());
          historyLoanListNotifier.loadLoan(loaner.id);
          adminHistoryLoanListNotifier.setTData(
              loaner, await historyLoanListNotifier.copy());
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              LoanersBar(onTap: (key) async {
                tokenExpireWrapper(ref, () async {
                  loanerIdNotifier.setId(key.id);
                  loanersItems.whenData(
                    (value) async {
                      final itemListNotifier =
                          ref.read(itemListProvider.notifier);
                      final loanersItemsNotifier =
                          ref.read(loanersItemsProvider.notifier);
                      final listItems = value[key];
                      if (listItems == null) {
                        loanersItemsNotifier.autoLoadList(ref, key,
                            (key) => itemListNotifier.loadItemList(key.id));
                      } else {
                        listItems.whenData((value) async {
                          if (value.isEmpty) {
                            loanersItemsNotifier.autoLoadList(ref, key,
                                (key) => itemListNotifier.loadItemList(key.id));
                          }
                        });
                      }
                    },
                  );
                  adminLoanList.whenData(
                    (value) async {
                      final loanListNotifier =
                          ref.read(loanerLoanListProvider.notifier);
                      final adminLoanListNotifier =
                          ref.read(adminLoanListProvider.notifier);
                      final listItems = value[key];
                      if (listItems == null) {
                        adminLoanListNotifier.autoLoadList(ref, key,
                            (key) => loanListNotifier.loadLoan(key.id));
                      } else {
                        listItems.whenData((value) async {
                          if (value.isEmpty) {
                            adminLoanListNotifier.autoLoadList(ref, key,
                                (key) => loanListNotifier.loadLoan(key.id));
                          }
                        });
                      }
                    },
                  );
                  adminHistoryLoanList.whenData(
                    (value) async {
                      final historyLoanListNotifier =
                          ref.read(historyLoanerLoanListProvider.notifier);
                      final adminHistoryLoanListNotifier =
                          ref.read(adminHistoryLoanListProvider.notifier);
                      final listItems = value[key];
                      if (listItems == null) {
                        adminHistoryLoanListNotifier.autoLoadList(ref, key,
                            (key) => historyLoanListNotifier.loadLoan(key.id));
                      } else {
                        listItems.whenData((value) async {
                          if (value.isEmpty) {
                            adminHistoryLoanListNotifier.autoLoadList(
                                ref,
                                key,
                                (key) =>
                                    historyLoanListNotifier.loadLoan(key.id));
                          }
                        });
                      }
                    },
                  );
                });
              }),
              const Column(
                children: [
                  SizedBox(height: 25),
                  OnGoingLoan(),
                  SizedBox(height: 25),
                  LoanersItems(),
                  SizedBox(height: 25),
                  HistoryLoan(),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
