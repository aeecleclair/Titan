import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/admin_history_loan_list_provider.dart';
import 'package:titan/loan/providers/admin_loan_list_provider.dart';
import 'package:titan/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loaner_id_provider.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/ui/loan.dart';
import 'package:titan/loan/ui/pages/admin_page/loan_history.dart';
import 'package:titan/loan/ui/pages/admin_page/loaners_bar.dart';
import 'package:titan/loan/ui/pages/admin_page/loaners_items.dart';
import 'package:titan/loan/ui/pages/admin_page/on_going_loan.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

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
        controller: ScrollController(),
        onRefresh: () async {
          final itemListNotifier = ref.read(itemListProvider.notifier);
          final loanersItemsNotifier = ref.read(loanersItemsProvider.notifier);
          final loanListNotifier = ref.read(loanerLoanListProvider.notifier);
          final historyLoanListNotifier = ref.read(
            historyLoanerLoanListProvider.notifier,
          );
          final adminLoanListNotifier = ref.read(
            adminLoanListProvider.notifier,
          );
          final adminHistoryLoanListNotifier = ref.read(
            adminHistoryLoanListProvider.notifier,
          );
          itemListNotifier.loadItemList(loaner.id);
          loanersItemsNotifier.setTData(loaner, await itemListNotifier.copy());
          loanListNotifier.loadLoan(loaner.id);
          adminLoanListNotifier.setTData(loaner, await loanListNotifier.copy());
          historyLoanListNotifier.loadLoan(loaner.id);
          adminHistoryLoanListNotifier.setTData(
            loaner,
            await historyLoanListNotifier.copy(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              LoanersBar(
                onTap: (key) async {
                  tokenExpireWrapper(ref, () async {
                    loanerIdNotifier.setId(key.id);
                    final itemListNotifier = ref.read(
                      itemListProvider.notifier,
                    );
                    final loanersItemsNotifier = ref.read(
                      loanersItemsProvider.notifier,
                    );
                    final listItems = loanersItems[key];
                    if (listItems == null) {
                      loanersItemsNotifier.autoLoadList(
                        ref,
                        key,
                        (key) => itemListNotifier.loadItemList(key.id),
                      );
                    } else {
                      listItems.whenData((loanersItems) async {
                        if (loanersItems.isEmpty) {
                          loanersItemsNotifier.autoLoadList(
                            ref,
                            key,
                            (key) => itemListNotifier.loadItemList(key.id),
                          );
                        }
                      });
                    }
                    final loanListNotifier = ref.read(
                      loanerLoanListProvider.notifier,
                    );
                    final adminLoanListNotifier = ref.read(
                      adminLoanListProvider.notifier,
                    );
                    final listAdminItems = adminLoanList[key];
                    if (listAdminItems == null) {
                      adminLoanListNotifier.autoLoadList(
                        ref,
                        key,
                        (key) => loanListNotifier.loadLoan(key.id),
                      );
                    } else {
                      listAdminItems.whenData((adminLoanList) async {
                        if (adminLoanList.isEmpty) {
                          adminLoanListNotifier.autoLoadList(
                            ref,
                            key,
                            (key) => loanListNotifier.loadLoan(key.id),
                          );
                        }
                      });
                    }

                    final historyLoanListNotifier = ref.read(
                      historyLoanerLoanListProvider.notifier,
                    );
                    final adminHistoryLoanListNotifier = ref.read(
                      adminHistoryLoanListProvider.notifier,
                    );
                    final listAdminHistoryItems = adminHistoryLoanList[key];
                    if (listAdminHistoryItems == null) {
                      adminHistoryLoanListNotifier.autoLoadList(
                        ref,
                        key,
                        (key) => historyLoanListNotifier.loadLoan(key.id),
                      );
                    } else {
                      listAdminHistoryItems.whenData((
                        adminHistoryLoanList,
                      ) async {
                        if (adminHistoryLoanList.isEmpty) {
                          adminHistoryLoanListNotifier.autoLoadList(
                            ref,
                            key,
                            (key) => historyLoanListNotifier.loadLoan(key.id),
                          );
                        }
                      });
                    }
                  });
                },
              ),
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
