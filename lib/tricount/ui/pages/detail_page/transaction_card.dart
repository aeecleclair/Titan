import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/tricount/tools/functions.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff09263D),
            child: Text(
              getAvatarName(transaction.payer),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AutoSizeText(transaction.title, maxLines: 1, style: const TextStyle(
                color: Color(0xff09263D),
                fontSize: 20,
                fontWeight: FontWeight.bold))
          ),
          const SizedBox(width: 10),
          Text(
            "${transaction.amount.toStringAsFixed(2)}€",
            style: const TextStyle(
                color: Color(0xff09263D),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
