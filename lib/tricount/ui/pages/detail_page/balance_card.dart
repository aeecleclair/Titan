import 'package:flutter/material.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/tricount/tools/functions.dart';

class BalanceCard extends StatelessWidget {
  final Transaction transaction;
  final double maxAbsBalance;
  final bool isMe; 
  const BalanceCard(
      {super.key, required this.transaction, required this.maxAbsBalance, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction.amount >= 0;
    return SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: isPositive
                  ? Container(
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        transaction.payer.nickname ??
                            transaction.payer.firstname,
                        style: TextStyle(
                            color: Color(0xff09263D),
                            fontSize: 20,
                            fontWeight: isMe ? FontWeight.bold : FontWeight.normal),
                      ))
                  : LayoutBuilder(builder: (context, constraints) {
                      final textOverflowing = hasTextOverflow(
                          transaction.payer.nickname ??
                              transaction.payer.firstname,
                          const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxWidth: transaction.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth -
                              30);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (textOverflowing)
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${transaction.amount}€',
                                style: const TextStyle(
                                    color: Color(0xff09263D),
                                    fontSize: 18),
                              ),
                            ),
                          Container(
                              width: transaction.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth,
                              height: 50,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 223, 2, 68),
                                        Color.fromARGB(255, 255, 255, 255)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: textOverflowing
                                  ? null
                                  : Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${transaction.amount}€',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    )),
                        ],
                      );
                    }),
            )),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: isPositive
                  ? LayoutBuilder(builder: (context, constraints) {
                      final textOverflowing = hasTextOverflow(
                          transaction.payer.nickname ??
                              transaction.payer.firstname,
                          const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxWidth: transaction.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth -
                              30);
                      return Row(
                        children: [
                          Container(
                              width: transaction.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth,
                              height: 60,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 1, 165, 1)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: textOverflowing
                                  ? null
                                  : Container(
                                margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${transaction.amount}€',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              )),
                          if (textOverflowing)
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${transaction.amount}€',
                                style: const TextStyle(
                                    color: Color(0xff09263D),
                                    fontSize: 18),
                              ),
                            ),
                        ],
                      );
                    })
                  : Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        transaction.payer.nickname ??
                            transaction.payer.firstname,
                        style: TextStyle(
                            color: Color(0xff09263D),
                            fontSize: 20,
                            fontWeight: isMe ? FontWeight.bold : FontWeight.normal),
                      )),
            ))
          ],
        ));
  }
}
