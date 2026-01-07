import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/mypayment/class/history.dart';

class SummaryCard extends StatelessWidget {
  final List<History> history;
  const SummaryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    int numberTransactions = 0;

    for (final transaction in history) {
      if (transaction.status == TransactionStatus.canceled) {
        continue; // Only consider successful transactions
      }
      switch (transaction.type) {
        case HistoryType.given:
          total -= transaction.total;
          numberTransactions++;
          break;
        case HistoryType.refundDebited:
          total -= transaction.total;
          break;

        case HistoryType.received:
          total += transaction.total;
          numberTransactions++;
          break;
        case HistoryType.refundCredited:
          total += transaction.total;
          break;

        case HistoryType.transfer:
          total += transaction.total;
          break;
      }
    }

    if (numberTransactions == 0) {
      return const SizedBox();
    }

    final mean = total / numberTransactions;

    final formatter = NumberFormat("#,##0.00", "fr_FR");
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundColor: Color(0xff017f80),
            child: HeroIcon(
              HeroIcons.listBullet,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AutoSizeText(
                      "Total sur la période",
                      maxLines: 2,
                      style: TextStyle(color: Color(0xff204550), fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Moyenne : ${formatter.format(mean / 100)} € / transaction",
                  style: const TextStyle(
                    color: Color(0xff204550),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "${formatter.format(total / 100)} €",
            style: TextStyle(
              color: const Color(0xff204550),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decorationColor: const Color(0xff204550).withValues(alpha: 0.8),
              decorationThickness: 2.85,
            ),
          ),
        ],
      ),
    );
  }
}
