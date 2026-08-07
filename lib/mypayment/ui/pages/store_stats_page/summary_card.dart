import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class SummaryCard extends ConsumerWidget {
  final List<History> history;
  const SummaryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);

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
          CircleAvatar(
            radius: 27,
            backgroundColor: MyPaymentColors(isDarkTheme).gradient1,
            child: HeroIcon(
              HeroIcons.listBullet,
              color: MyPaymentColors.onGradient,
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
                    AutoSizeText(
                      "Total sur la période",
                      maxLines: 2,
                      style: TextStyle(
                        color: MyPaymentColors(isDarkTheme).secondaryGreen,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Moyenne : ${formatter.format(mean / 100)} € / transaction",
                  style: TextStyle(
                    color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
              color: MyPaymentColors(isDarkTheme).secondaryGreen,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decorationColor: MyPaymentColors(
                isDarkTheme,
              ).secondaryGreen.withValues(alpha: 0.8),
              decorationThickness: 2.85,
            ),
          ),
        ],
      ),
    );
  }
}
