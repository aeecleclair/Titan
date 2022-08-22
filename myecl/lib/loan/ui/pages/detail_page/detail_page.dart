import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_history_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/dialog.dart';
import 'package:myecl/loan/ui/pages/detail_page/button.dart';
import 'package:myecl/loan/ui/pages/detail_page/delay_dialog.dart';
import 'package:myecl/tools/functions.dart';

class DetailPage extends HookConsumerWidget {
  final bool isAdmin;
  const DetailPage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loanHistoryNotifier = ref.watch(loanHistoryProvider.notifier);
    return Stack(
      children: [
        Column(children: [
          Expanded(
            child: Container(
              color: Colors.grey[50],
            ),
          ),
          Expanded(
            child: Container(
              color: LoanColorConstants.darkGrey,
            ),
          ),
        ]),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: LoanColorConstants.darkGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Text(
                            loan.loaner.name,
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: LoanColorConstants.veryLightOrange),
                          ),
                          Text(
                            loan.borrower.getName(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: LoanColorConstants.orange),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          loan.items
                                  .fold(0, (a, b) => (a as int) + b.caution)
                                  .toString() +
                              '€',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: LoanColorConstants.veryLightOrange),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    processDate(loan.start) + ' - ' + processDate(loan.end),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: LoanColorConstants.veryLightOrange),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                ...loan.items
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text("-",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: LoanColorConstants.lightOrange)),
                                const SizedBox(width: 20),
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: LoanColorConstants.lightOrange),
                                ),
                              ],
                            ),
                            Text(
                              e.caution.toString() + '€',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: LoanColorConstants.lightOrange),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    loan.notes,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: LoanColorConstants.veryLightOrange),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                isAdmin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LoanButton(
                              onPressed: () {
                                showDialog<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DelayDialog(onYes: (i) {
                                      Loan newLoan = loan.copyWith(
                                          end: loan.end.add(Duration(days: i)));
                                      loanNotifier.setLoan(newLoan);
                                      loanListNotifier.extendLoan(newLoan, i);
                                    });
                                  },
                                );
                              },
                              icon: HeroIcons.clock),
                          LoanButton(
                            onPressed: () {
                              loanNotifier.setLoan(loan).then((_) {
                                ref.watch(itemListProvider);
                                pageNotifier.setLoanPage(LoanPage.editLoan);
                              });
                            },
                            icon: HeroIcons.pencilAlt,
                          ),
                          LoanButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return LoanDialog(
                                      title: LoanTextConstants.delete,
                                      descriptions:
                                          LoanTextConstants.deleteLoan,
                                      onYes: () {
                                        loanListNotifier.returnLoan(loan);
                                        loanHistoryNotifier.addLoan(loan);
                                        pageNotifier
                                            .setLoanPage(LoanPage.adminLoan);
                                      },
                                    );
                                  });
                            },
                            icon: HeroIcons.hand,
                          ),
                          LoanButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return LoanDialog(
                                      title: LoanTextConstants.delete,
                                      descriptions:
                                          LoanTextConstants.deleteLoan,
                                      onYes: () {
                                        loanListNotifier.deleteLoan(loan);
                                        pageNotifier
                                            .setLoanPage(LoanPage.adminLoan);
                                      },
                                    );
                                  });
                            },
                            icon: HeroIcons.x,
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
