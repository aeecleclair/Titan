import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_history_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/dialog.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/detail_page/button.dart';
import 'package:myecl/loan/ui/pages/detail_page/delay_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class DetailPage extends HookConsumerWidget {
  final bool isAdmin;
  const DetailPage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider);
    final loaner = ref.watch(loanerProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminloanListNotifier = ref.watch(adminLoanListProvider.notifier);
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
                          loan.caution,
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
                    '${processDate(loan.start)} - ${processDate(loan.end)}',
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
                              '${e.caution}€',
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
                                    return DelayDialog(onYes: (i) async {
                                      Loan newLoan = loan.copyWith(
                                          end: loan.end.add(Duration(days: i)));
                                      await loanNotifier.setLoan(newLoan);
                                      tokenExpireWrapper(ref, () async {
                                        final value = await loanListNotifier
                                            .extendLoan(newLoan, i);
                                        if (value) {
                                          displayLoanToast(context, TypeMsg.msg,
                                              LoanTextConstants.extendedLoan);
                                        } else {
                                          displayLoanToast(
                                              context,
                                              TypeMsg.error,
                                              LoanTextConstants.extendingError);
                                        }
                                      });
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
                            icon: HeroIcons.pencilSquare,
                          ),
                          LoanButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return LoanDialog(
                                      title: LoanTextConstants.returningLoan,
                                      descriptions:
                                          LoanTextConstants.returnLoan,
                                      onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                          final value = await loanListNotifier
                                              .returnLoan(loan);
                                          if (value) {
                                            pageNotifier.setLoanPage(
                                                LoanPage.adminLoan);
                                            await adminloanListNotifier
                                                .setTData(
                                                    loaner,
                                                    await loanListNotifier
                                                        .copy());
                                            displayLoanToast(
                                                context,
                                                TypeMsg.msg,
                                                LoanTextConstants.returnedLoan);
                                          } else {
                                            displayLoanToast(
                                                context,
                                                TypeMsg.msg,
                                                LoanTextConstants
                                                    .returningError);
                                          }
                                        });
                                        loanHistoryNotifier.addLoan(
                                            loaner, loan);
                                      },
                                    );
                                  });
                            },
                            icon: HeroIcons.handRaised,
                          ),
                          LoanButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return LoanDialog(
                                      title: LoanTextConstants.delete,
                                      descriptions:
                                          LoanTextConstants.deletingLoan,
                                      onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                          final value = await loanListNotifier
                                              .deleteLoan(loan);
                                          if (value) {
                                            await adminloanListNotifier
                                                .setTData(
                                                    loaner,
                                                    await loanListNotifier
                                                        .copy());
                                            pageNotifier.setLoanPage(
                                                LoanPage.adminLoan);
                                            displayLoanToast(
                                                context,
                                                TypeMsg.msg,
                                                LoanTextConstants.deletedLoan);
                                          } else {
                                            displayLoanToast(
                                                context,
                                                TypeMsg.msg,
                                                LoanTextConstants
                                                    .deletingError);
                                          }
                                        });
                                      });
                                },
                              );
                            },
                            icon: HeroIcons.xMark,
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
