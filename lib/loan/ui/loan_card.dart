import 'package:flutter/material.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final bool isAdmin;
  final Function() onEdit, onCalendar, onReturn;
  const LoanCard(
      {super.key,
      required this.loan,
      required this.onEdit,
      required this.onCalendar,
      required this.onReturn,
      required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Container(
                    alignment: Alignment.center,
                    child: Text(capitalize(loan.loaner.name),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  const SizedBox(height: 5),
                ]),
              const SizedBox(height: 10),
              Text(loan.borrower.getName(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
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
                      DateTime.now().compareTo(loan.end) <= 0
                          ? LoanTextConstants.onGoing
                          : LoanTextConstants.ended,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400)),
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
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: onCalendar,
                      child: Container(
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
                        child: const Icon(Icons.calendar_month_outlined,
                            color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: onReturn,
                      child: Container(
                        width: 40,
                        height: 40,
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
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
