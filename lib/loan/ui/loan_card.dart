import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final bool isAdmin, isDetail;
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
      required this.isDetail});

  @override
  Widget build(BuildContext context) {
    final shouldReturn = DateTime.now().compareTo(loan.end) > 0;
    return GestureDetector(
      onTap: () {
        if (isAdmin) {
          onInfo();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200.withOpacity(0.5),
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
                if (!isAdmin)
                  Column(children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 25,
                        ),
                        Text(capitalize(loan.loaner.name),
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        !isDetail
                            ? GestureDetector(
                                onTap: onInfo,
                                child: const HeroIcon(
                                    HeroIcons.informationCircle,
                                    color: Colors.black,
                                    size: 25),
                              )
                            : Container(width: 25),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ]),
                const SizedBox(height: 10),
                Text(loan.borrower.getName(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 3),
                Text(formatItems(loan.items),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400)),
                Text(loan.caution,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        shouldReturn
                            ? LoanTextConstants.toReturn
                            : LoanTextConstants.onGoing,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: shouldReturn
                                ? const Color.fromARGB(255, 172, 32, 10)
                                : Colors.grey.shade400)),
                    Text(processDate(loan.end),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400)),
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
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const HeroIcon(HeroIcons.pencil,
                              color: Colors.black),
                        ),
                      ),
                      ShrinkButton(
                          waitChild: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              ))),
                          onTap: onCalendar,
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(2, 3))
                              ],
                            ),
                            child: const HeroIcon(HeroIcons.calendarDays,
                                color: Colors.black),
                          )),
                      ShrinkButton(
                          waitChild: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                              color: Colors.black,
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
