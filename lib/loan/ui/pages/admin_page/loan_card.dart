import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/card_button.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final bool isAdmin, isDetail, isHistory;
  final Function() onEdit, onInfo;
  final Future Function() onCalendar, onReturn;
  static void noAction() {}
  static Future noAsyncAction() async {}
  const LoanCard(
      {super.key,
      required this.loan,
      this.onEdit = noAction,
      this.onCalendar = noAsyncAction,
      this.onReturn = noAsyncAction,
      this.onInfo = noAction,
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
          onInfo();
        }
      },
      child: CardLayout(
        width: 250,
        height: (isAdmin && !isDetail) ? 170 : isHistory ? 110 : 160,
        colors: shouldReturn
            ? [
                const Color.fromARGB(255, 250, 66, 38),
                const Color.fromARGB(255, 172, 32, 10)
              ]
            : [Colors.white, Colors.white],
        shadowColor: shouldReturn
            ? const Color.fromARGB(255, 172, 32, 10).withOpacity(0.25)
            : const Color(0x80EEEEEE),
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
                    Container(
                      width: 25,
                    ),
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
                            ? const Color.fromARGB(255, 99, 13, 0)
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
                              ? const Color.fromARGB(255, 99, 13, 0)
                              : Colors.black),
                    ),
                  ),
                  ShrinkButton(
                    waitingColor: shouldReturn
                        ? const Color.fromARGB(255, 99, 13, 0)
                        : Colors.black,
                    builder: (child) => CardButton(
                        color: shouldReturn
                            ? Colors.white.withOpacity(0.7)
                            : Colors.grey.shade200,
                        child: child),
                    onTap: onCalendar,
                    child: HeroIcon(HeroIcons.calendarDays,
                        color: shouldReturn
                            ? const Color.fromARGB(255, 99, 13, 0)
                            : Colors.black),
                  ),
                  ShrinkButton(
                    builder: (child) => CardButton(
                        color: shouldReturn
                            ? const Color.fromARGB(255, 99, 13, 0)
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
