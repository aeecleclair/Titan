import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/class/history.dart';

class SummaryCard extends StatelessWidget {
  final List<History> history;
  const SummaryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    int numberTransactions = 0;

    for (final transaction in history) {
      switch (transaction.status) {
        case TransactionStatus.confirmed:
          total += transaction.total;
          numberTransactions++;
          break;
        case TransactionStatus.refunded:
          total -= transaction.total;
          numberTransactions++;
          break;
        default:
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
              HeroIcons.arrowDownRight,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AutoSizeText(
                      "Total du mois",
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xff204550),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
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
          const SizedBox(
            width: 10,
          ),
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
