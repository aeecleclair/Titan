import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/ui/pages/main_page/account_card/day_divider.dart';
import 'package:titan/paiement/ui/components/transaction_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:timeago/timeago.dart' as timeago;

class LastTransactions extends ConsumerWidget {
  final double maxHeight;
  const LastTransactions({required this.maxHeight, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(myHistoryProvider);
    return SizedBox(
      height: maxHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Dernières transactions",
                style: TextStyle(
                  color: Color(0xff204550),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            AsyncChild(
              value: history,
              builder: (context, history) {
                final Map<String, List<History>> groupedByDay = {};
                final Map<String, DateTime> stringDate = {};
                for (var transaction in history.where(
                  (h) => h.status != TransactionStatus.pending,
                )) {
                  final date = transaction.creation;
                  final day = timeago.format(date, locale: 'fr_short');
                  if (groupedByDay[day] == null) {
                    groupedByDay[day] = [];
                    stringDate[day] = date;
                  }
                  groupedByDay[day]!.add(transaction);
                }
                final sortedByDayKeys = stringDate.keys.toList()
                  ..sort((a, b) => stringDate[b]!.compareTo(stringDate[a]!));
                final sortedByDay = {
                  for (var key in sortedByDayKeys) key: groupedByDay[key],
                };
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: sortedByDay
                        .map((day, transactions) {
                          final dateOrderedTransactions = transactions!
                            ..sort((a, b) => b.creation.compareTo(a.creation));
                          return MapEntry(
                            day,
                            Column(
                              children: [
                                DayDivider(date: day),
                                for (var transaction in dateOrderedTransactions)
                                  TransactionCard(transaction: transaction),
                              ],
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                );
              },
              errorBuilder: (error, stack) => Center(
                child: Text(
                  "Erreur lors de la récupération des transactions : $error",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
