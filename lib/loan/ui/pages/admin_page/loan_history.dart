import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_history_loan_list_provider.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';

class HistoryLoan extends HookConsumerWidget {
  const HistoryLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final historyLoanListNotifier =
        ref.watch(historyLoanerLoanListProvider.notifier);
    final loanList = ref.watch(historyLoanerLoanListProvider);
    final adminHistoryLoanListNotifier =
        ref.watch(adminHistoryLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminHistoryLoanListProvider);
    final editingController = useTextEditingController();
    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return AsyncChild(
        value: adminLoanList,
        builder: (context, loans) {
          final loan = loans[loaner];
          if (loan == null) {
            return const Loader();
          }
          return AsyncChild(
              value: loan,
              builder: (context, data) {
                if (data.isNotEmpty) {
                  data.sort((a, b) => b.end.compareTo(a.end));
                }
                return Column(
                  children: [
                    StyledSearchBar(
                      label: LoanTextConstants.history,
                      onChanged: (value) async {
                        if (editingController.text.isNotEmpty) {
                          adminHistoryLoanListNotifier.setTData(
                              loaner,
                              await historyLoanListNotifier
                                  .filterLoans(editingController.text));
                        } else {
                          adminHistoryLoanListNotifier.setTData(
                              loaner, loanList);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: HorizontalListView(
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            ...data
                                .map((e) => LoanCard(loan: e, isHistory: true))
                                .toList(),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
        });
  }
}
