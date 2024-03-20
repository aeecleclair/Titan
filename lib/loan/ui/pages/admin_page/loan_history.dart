import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaners_history_loans_map_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HistoryLoan extends HookConsumerWidget {
  const HistoryLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoaner = ref.watch(selectedLoanerProvider);

    final loanNotifier = ref.read(loanProvider.notifier);

    final loanListNotifier = ref.read(loanListProvider.notifier);
    final loanersHistoryLoansMapNotifier =
        ref.watch(loanersHistoryLoansMapProvider.notifier);
    final loanerHistoryLoans = ref.watch(
      loanersHistoryLoansMapProvider.select((map) => map[selectedLoaner]),
    );

    final ValueNotifier<String> filterQuery = useState("");

    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return AutoLoaderChild(
      group: loanerHistoryLoans,
      notifier: loanersHistoryLoansMapNotifier,
      mapKey: selectedLoaner,
      listLoader: (loaner) {
        return loanListNotifier.loadHistory(loaner.id);
      },
      dataBuilder: (context, loans) {
        if (loans.isEmpty) {
          return const Center(
            child: Text(LoanTextConstants.noLoan),
          );
        }
        loans.sort((a, b) => b.returnedDate!.compareTo(a.returnedDate!));
        return Column(
          children: [
            StyledSearchBar(
              label: LoanTextConstants.history,
              onChanged: (query) async {
                filterQuery.value = query;
              },
            ),
            const SizedBox(height: 10),
            HorizontalListView.builder(
              height: 120,
              items: filteredLoans(loans, filterQuery.value),
              itemBuilder: (context, loan, i) => LoanCard(
                loan: loan,
                onInfo: () {
                  loanNotifier.setLoan(loan);
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.detail,
                  );
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
