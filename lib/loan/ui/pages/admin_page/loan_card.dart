import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final bool isAdmin, isDetail, isHistory;
  final Function()? onEdit, onInfo;
  final Future Function()? onCalendar, onReturn;
  const LoanCard(
      {super.key,
      required this.loan,
      this.onEdit,
      this.onCalendar,
      this.onReturn,
      this.onInfo,
      this.isAdmin = false,
      this.isDetail = false,
      this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    final shouldReturn =
        DateTime.now().compareTo(loan.end) > 0 && !loan.returned;
    return GestureDetector(
      onTap: () {
        if (isAdmin) {
          onInfo?.call();
        }
      },
      child: CardLayout(
        id: loan.id,
        width: 250,
        height: (isAdmin && !isDetail)
            ? 170
            : isHistory
                ? 110
                : 160,
        colors: shouldReturn
            ? [
                LoanColorConstants.redGradient1,
                LoanColorConstants.redGradient2,
              ]
            : [Colors.white, Colors.white],
        shadowColor: shouldReturn
            ? LoanColorConstants.redGradient2.withOpacity(0.25)
            : LoanColorConstants.shadowColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isAdmin && !isHistory)
              Column(children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 25),
                    AutoSizeText(capitalize(loan.loaner.name),
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: shouldReturn ? Colors.white : Colors.black)),
                    !isDetail
                        ? GestureDetector(
                            onTap: onInfo,
                            child: HeroIcon(HeroIcons.informationCircle,
                                color:
                                    shouldReturn ? Colors.white : Colors.black,
                                size: 25),
                          )
                        : Container(width: 25),
                  ],
                ),
                const SizedBox(height: 5),
              ]),
            SizedBox(height: !isAdmin && !isHistory ? 5 : 10),
            AutoSizeText(loan.borrower.getName(),
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: shouldReturn ? Colors.white : Colors.black)),
            const SizedBox(height: 7),
            Text(formatItems(loan.itemsQuantity),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: shouldReturn
                        ? Colors.white.withOpacity(0.8)
                        : Colors.grey.shade400)),
            const SizedBox(height: 5),
            Text(loan.caution,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: shouldReturn ? Colors.white : Colors.black)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    loan.returned
                        ? LoanTextConstants.returned
                        : shouldReturn
                            ? LoanTextConstants.toReturn
                            : LoanTextConstants.onGoing,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: shouldReturn
                            ? LoanColorConstants.urgentRed
                            : Colors.grey.shade400)),
                Text(processDate(loan.end),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: shouldReturn
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey.shade400)),
              ],
            ),
            const Spacer(),
            if (isAdmin)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: CardButton(
                      color: shouldReturn
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey.shade200,
                      child: HeroIcon(HeroIcons.pencil,
                          color: shouldReturn
                              ? LoanColorConstants.urgentRed
                              : Colors.black),
                    ),
                  ),
                  WaitingButton(
                    waitingColor: shouldReturn
                        ? LoanColorConstants.urgentRed
                        : Colors.black,
                    builder: (child) => CardButton(
                        color: shouldReturn
                            ? Colors.white.withOpacity(0.7)
                            : Colors.grey.shade200,
                        child: child),
                    onTap: onCalendar,
                    child: HeroIcon(HeroIcons.calendarDays,
                        color: shouldReturn
                            ? LoanColorConstants.urgentRed
                            : Colors.black),
                  ),
                  WaitingButton(
                    builder: (child) => CardButton(
                        color: shouldReturn
                            ? LoanColorConstants.urgentRed
                            : Colors.black,
                        child: child),
                    onTap: onReturn,
                    child: const HeroIcon(HeroIcons.check, color: Colors.white),
                  ),
                ],
              ),
            if (!isHistory) const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
