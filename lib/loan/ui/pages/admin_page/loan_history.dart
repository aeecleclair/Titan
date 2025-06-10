import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/admin_history_loan_list_provider.dart';
import 'package:titan/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loan_focus_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/loan/ui/pages/admin_page/loan_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HistoryLoan extends HookConsumerWidget {
  const HistoryLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanNotifier = ref.read(loanProvider.notifier);
    final historyLoanListNotifier = ref.watch(
      historyLoanerLoanListProvider.notifier,
    );
    final loanList = ref.watch(historyLoanerLoanListProvider);
    final adminHistoryLoanListNotifier = ref.watch(
      adminHistoryLoanListProvider.notifier,
    );
    final adminLoanList = ref.watch(adminHistoryLoanListProvider);
    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    final loan = adminLoanList[loaner];
    if (loan == null) {
      return const Loader();
    }
    return AsyncChild(
      value: loan,
      builder: (context, data) {
        if (data.isNotEmpty) {
          data.sort((a, b) => b.returnedDate!.compareTo(a.returnedDate!));
        }
        return Column(
          children: [
            StyledSearchBar(
              label: LoanTextConstants.history,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  adminHistoryLoanListNotifier.setTData(
                    loaner,
                    await historyLoanListNotifier.filterLoans(value),
                  );
                } else {
                  adminHistoryLoanListNotifier.setTData(loaner, loanList);
                }
              },
            ),
            const SizedBox(height: 10),
            HorizontalListView.builder(
              height: 120,
              items: data,
              itemBuilder: (context, loan, i) => LoanCard(
                loan: loan,
                onInfo: () {
                  loanNotifier.setLoan(loan);
                  QR.to(LoanRouter.root + LoanRouter.admin + LoanRouter.detail);
                },
                isHistory: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
