import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/history_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/day_divider.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class LastTransactions extends ConsumerWidget {
  const LastTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    return Column(
      children: [
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
        const SizedBox(
          height: 15,
        ),
        AsyncChild(
            value: history,
            builder: (context, history) {
              final groupedByDay = {};
              history.forEach((transaction) {
                final date = transaction.creation;
                final day = DateTime(date.year, date.month, date.day);
                if (groupedByDay[day] == null) {
                  groupedByDay[day] = [];
                }
                groupedByDay[day].add(transaction);
              });
              final sortedByDayKeys = groupedByDay.keys.toList()
                ..sort((a, b) => b.compareTo(a));
              final sortedByDay = {
                for (var key in sortedByDayKeys) key: groupedByDay[key]
              };
              return Column(
                children: sortedByDay
                    .map((day, transactions) {
                      return MapEntry(
                        day,
                        Column(
                          children: [
                            DayDivider(
                              date: day,
                            ),
                            for (var transaction in transactions)
                              TransactionCard(
                                transaction: transaction,
                              ),
                          ],
                        ),
                      );
                    })
                    .values
                    .toList(),
              );
            },),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
