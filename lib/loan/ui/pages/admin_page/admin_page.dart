import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/ui/loan.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_history.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_bar.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_items.dart';
import 'package:myecl/loan/ui/pages/admin_page/on_going_loan.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoanerNotifier = ref.read(selectedLoanerProvider.notifier);

    return LoanTemplate(
      child: Refresher(
        onRefresh: () async {
          //TODO Refresh loans and items
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              LoanersBar(
                onTap: (loanerTapped) async {
                  tokenExpireWrapper(ref, () async {
                    selectedLoanerNotifier.setLoaner(loanerTapped);
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
