import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final bool isAdmin, isDetail, isHistory;
  final Function() onEdit, onInfo;
  final Future Function() onCalendar, onReturn;
  const LoanCard(
      {super.key,
      required this.loan,
      required this.onEdit,
      required this.onCalendar,
      required this.onReturn,
      required this.onInfo,
      required this.isAdmin,
      required this.isDetail,
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
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 250,
          height: isAdmin || !isHistory ? 200 : 180,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: shouldReturn
                  ? [
                      const Color.fromARGB(255, 250, 66, 38),
                      const Color.fromARGB(255, 172, 32, 10)
                    ]
                  : [Colors.white, Colors.grey.shade50],
              center: Alignment.topLeft,
              radius: 1.5,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: shouldReturn
                    ? const Color.fromARGB(255, 172, 32, 10).withOpacity(0.25)
                    : Colors.grey.shade200.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
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
                                color: shouldReturn
                                    ? Colors.white
                                    : Colors.black)),
                        !isDetail
                            ? GestureDetector(
                                onTap: onInfo,
                                child: HeroIcon(HeroIcons.informationCircle,
                                    color: shouldReturn
                                        ? Colors.white
                                        : Colors.black,
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
                        color: shouldReturn
                            ? Colors.white
                            : Colors.black)),
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
                        color: shouldReturn
                            ? Colors.white
                            : Colors.black)),
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
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: shouldReturn
                                ? Colors.white.withOpacity(0.7)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: HeroIcon(HeroIcons.pencil,
                              color: shouldReturn
                                  ? const Color.fromARGB(255, 99, 13, 0)
                                  : Colors.black),
                        ),
                      ),
                      ShrinkButton(
                          waitChild: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: shouldReturn
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: shouldReturn
                                    ? const Color.fromARGB(255, 99, 13, 0)
                                    : Colors.black,
                              ))),
                          onTap: onCalendar,
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: shouldReturn
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(2, 3))
                              ],
                            ),
                            child: HeroIcon(HeroIcons.calendarDays,
                                color: shouldReturn
                                    ? const Color.fromARGB(255, 99, 13, 0)
                                    : Colors.black),
                          )),
                      ShrinkButton(
                          waitChild: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: shouldReturn
                                  ? const Color.fromARGB(255, 99, 13, 0)
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(2, 3))
                              ],
                            ),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ),
                          onTap: onReturn,
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: shouldReturn
                                  ? const Color.fromARGB(255, 99, 13, 0)
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(2, 3))
                              ],
                            ),
                            child: const HeroIcon(HeroIcons.check,
                                color: Colors.white),
                          )),
                    ],
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
