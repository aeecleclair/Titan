import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class LoanUi extends ConsumerWidget {
  final Loan l;
  final bool isHistory;
  final bool isAdmin;
  const LoanUi(
      {Key? key,
      required this.l,
      required this.isHistory,
      required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanNotifier = ref.watch(loanProvider.notifier);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          decoration: BoxDecoration(
            color: LoanColorConstants.veryLightOrange,
            boxShadow: [
              BoxShadow(
                color: LoanColorConstants.veryLightOrange.withOpacity(0.4),
                offset: const Offset(1, 2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              height: isAdmin || isHistory ? 80 : 65,
              width: 10,
              decoration: BoxDecoration(
                color: LoanColorConstants.lightOrange,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatItems(l.items),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: LoanColorConstants.darkGrey)),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(processDate(l.start) + " - " + processDate(l.end),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 145, 145, 145))),
                  isAdmin || isHistory
                      ? Column(children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(l.borrower.getName(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: LoanColorConstants.orange)),
                        ])
                      : Container()
                ],
              ),
            ),
          ])),
      onTap: () {
        pageNotifier.setLoanPage(isAdmin
            ? LoanPage.groupLoan
            : isHistory
                ? LoanPage.historyDetail
                : LoanPage.detail);
        loanNotifier.setLoan(l);
      },
    );
  }
}
