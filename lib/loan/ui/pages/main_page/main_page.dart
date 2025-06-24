import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/admin_loan_list_provider.dart';
import 'package:titan/loan/providers/is_loan_admin_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/loan/ui/loan.dart';
import 'package:titan/loan/ui/pages/admin_page/loan_card.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanMainPage extends HookConsumerWidget {
  const LoanMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanList = ref.watch(loanListProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final isAdmin = ref.watch(isLoanAdminProvider);

    ref.watch(adminLoanListProvider);
    ref.watch(itemListProvider);
    ref.watch(loanerLoanListProvider);
    List<Loan> onGoingLoan = [];
    List<Loan> returnedLoan = [];

    loanList.maybeWhen(
      data: (data) {
        if (data.isNotEmpty) {
          for (Loan l in data) {
            if (l.returned) {
              returnedLoan.add(l);
            } else {
              onGoingLoan.add(l);
            }
          }
          onGoingLoan.sort((a, b) => b.end.compareTo(a.end));
          returnedLoan.sort((a, b) => b.end.compareTo(a.end));
        }
      },
      orElse: () {},
    );

    return LoanTemplate(
      child: Stack(
        children: [
          Refresher(
            onRefresh: () async {
              await loanListNotifier.loadLoanList();
            },
            child: Column(
              children: [
                const SizedBox(height: 40),
                (onGoingLoan.isNotEmpty)
                    ? Column(
                        children: [
                          AlignLeftText(
                            '${onGoingLoan.length} ${LoanTextConstants.loan.toLowerCase()}${onGoingLoan.length > 1 ? 's' : ''} ${LoanTextConstants.onGoing.toLowerCase()}',
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 30),
                          HorizontalListView.builder(
                            height: 170,
                            items: onGoingLoan,
                            itemBuilder: (context, e, i) => LoanCard(
                              loan: e,
                              onInfo: () {
                                loanNotifier.setLoan(e);
                                QR.to(LoanRouter.root + LoanRouter.detail);
                              },
                            ),
                          ),
                        ],
                      )
                    : (returnedLoan.isEmpty)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  LoanTextConstants.noLoan,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : Container(),
                if (returnedLoan.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      AlignLeftText(
                        '${returnedLoan.length} ${LoanTextConstants.loan.toLowerCase()}${returnedLoan.length > 1 ? 's' : ''} ${LoanTextConstants.returned.toLowerCase()}${returnedLoan.length > 1 ? 's' : ''}',
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 30),
                      HorizontalListView.builder(
                        height: 190,
                        items: returnedLoan,
                        itemBuilder: (context, e, i) => LoanCard(
                          loan: e,
                          onInfo: () {
                            loanNotifier.setLoan(e);
                            QR.to(LoanRouter.root + LoanRouter.detail);
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (isAdmin)
            Positioned(
              top: 30,
              right: 30,
              child: AdminButton(
                onTap: () {
                  QR.to(LoanRouter.root + LoanRouter.admin);
                },
              ),
            ),
        ],
      ),
    );
  }
}
