import 'package:flutter/material.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/class/balance.dart';
import 'package:myecl/tricount/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class BalanceCard extends StatelessWidget {
  final Balance balance;
  final List<SimpleUser> members;
  final double maxAbsBalance;
  final bool isMe;
  const BalanceCard(
      {super.key,
      required this.balance,
      required this.members,
      required this.maxAbsBalance,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    final isPositive = balance.amount >= 0;
    final payer = getMember(members, balance.userId);
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
                        payer.nickname ?? payer.firstname,
                        style: TextStyle(
                            color: const Color(0xff09263D),
                            fontSize: 20,
                            fontWeight:
                                isMe ? FontWeight.bold : FontWeight.normal),
                      ))
                  : LayoutBuilder(builder: (context, constraints) {
                      final textOverflowing = hasTextOverflow(
                          payer.nickname ?? payer.firstname,
                          const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxWidth: balance.amount.abs() /
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
                                '${balance.amount}€',
                                style: const TextStyle(
                                    color: Color(0xff09263D), fontSize: 18),
                              ),
                            ),
                          Container(
                              width: balance.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 223, 2, 68),
                                        Colors.grey.shade50
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: textOverflowing
                                  ? null
                                  : Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${balance.amount}€',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
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
                          payer.nickname ?? payer.firstname,
                          const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxWidth: balance.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth -
                              30);
                      return Row(
                        children: [
                          Container(
                              width: balance.amount.abs() /
                                  maxAbsBalance *
                                  constraints.maxWidth,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.shade50,
                                        const Color.fromARGB(255, 1, 165, 1)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: textOverflowing
                                  ? null
                                  : Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${balance.amount}€',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    )),
                          if (textOverflowing)
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${balance.amount}€',
                                style: const TextStyle(
                                    color: Color(0xff09263D), fontSize: 18),
                              ),
                            ),
                        ],
                      );
                    })
                  : Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        payer.nickname ?? payer.firstname,
                        style: TextStyle(
                            color: const Color(0xff09263D),
                            fontSize: 20,
                            fontWeight:
                                isMe ? FontWeight.bold : FontWeight.normal),
                      )),
            ))
          ],
        ));
  }
}
