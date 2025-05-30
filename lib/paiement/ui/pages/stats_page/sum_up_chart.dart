import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/providers/my_history_provider.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';
import 'package:myecl/paiement/providers/selected_transactions_provider.dart';
import 'package:myecl/paiement/ui/pages/stats_page/sum_up_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class SumUpChart extends HookConsumerWidget {
  const SumUpChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(-1);
    final history = ref.watch(myHistoryProvider);
    final currentMonth = ref.watch(selectedMonthProvider);
    final selectedTransactionsNotifier = ref.read(
      selectedTransactionsProvider.notifier,
    );
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    const totalKey = "totalKey";
    final List<List<Color>> colors = [
      [
        const Color.fromARGB(255, 1, 127, 128),
        const Color.fromARGB(255, 0, 102, 103),
        const Color.fromARGB(255, 0, 44, 45).withValues(alpha: 0.3),
      ],
      [
        const Color.fromARGB(255, 4, 84, 84),
        const Color.fromARGB(255, 0, 68, 68),
        const Color.fromARGB(255, 0, 29, 29).withValues(alpha: 0.4),
      ],
      [
        const Color.fromARGB(255, 255, 119, 7),
        const Color.fromARGB(255, 230, 103, 0),
        const Color.fromARGB(255, 97, 44, 0).withValues(alpha: 0.2),
      ],
    ];
    final List<History> transfer = [];
    final Map<String, List<History>> transactionPerStore = {};

    return AsyncChild(
      value: history,
      builder: (context, history) {
        final confirmedTransaction = history.where(
          (element) =>
              (element.status == TransactionStatus.confirmed ||
                  element.status == TransactionStatus.refunded) &&
              element.creation.year == currentMonth.year &&
              element.creation.month == currentMonth.month,
        );
        for (final transaction in confirmedTransaction) {
          if (transaction.type == HistoryType.transfer) {
            transfer.add(transaction);
          } else {
            transactionPerStore[transaction.otherWalletName] = [
              ...?transactionPerStore[transaction.otherWalletName],
              transaction,
            ];
          }
        }
        final List<PieChartSectionData> chartPart = [];
        final List<String> keys = [];
        final Map<String, List<History>> mappedHistory = {};
        int total = 0;

        if (transfer.isNotEmpty) {
          final totalAmount = transfer.fold<int>(
            0,
            (previousValue, element) => previousValue + element.total,
          );
          total += totalAmount;
          mappedHistory[totalKey] = transfer;
          keys.add(totalKey);
          chartPart.add(
            PieChartSectionData(
              color: colors[2][0],
              value: sqrt(totalAmount / 100),
              title: '',
              radius: 60 + (keys.indexOf(totalKey) == selected.value ? 15 : 0),
              badgePositionPercentageOffset: 0.6,
              badgeWidget: SumUpCard(
                amount: '${formatter.format(totalAmount / 100)} €',
                color: colors[2][0],
                darkColor: colors[2][1],
                shadowColor: colors[2][2],
                title: 'Recharge',
              ),
            ),
          );
        }

        for (final (index, wallet) in transactionPerStore.keys.indexed) {
          final l = transactionPerStore[wallet]!;
          mappedHistory[wallet] = l;

          final totalAmount = l.fold<int>(0, (previousValue, element) {
            if (element.type == HistoryType.given) {
              return previousValue - element.total;
            }
            return previousValue + element.total;
          });
          total += totalAmount;
          keys.add(wallet);
          chartPart.add(
            PieChartSectionData(
              color: colors[index % 2][0],
              value: sqrt((totalAmount / 100).abs()),
              title: '',
              radius: 60 + (keys.indexOf(wallet) == selected.value ? 15 : 0),
              badgePositionPercentageOffset: 0.6,
              badgeWidget: SumUpCard(
                amount: '${formatter.format(totalAmount / 100)} €',
                color: colors[index % 2][0],
                darkColor: colors[index % 2][1],
                shadowColor: colors[index % 2][2],
                title: wallet,
              ),
            ),
          );
        }

        return Expanded(
          child: confirmedTransaction.isNotEmpty
              ? Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: true),
                          pieTouchData: PieTouchData(
                            touchCallback: (flTouchEvent, pieTouchResponse) {
                              final newValue =
                                  pieTouchResponse
                                      ?.touchedSection
                                      ?.touchedSectionIndex ??
                                  -1;
                              selected.value = newValue;
                              if (newValue == -1) {
                                selectedTransactionsNotifier
                                    .updateSelectedTransactions(
                                      confirmedTransaction.toList(),
                                    );
                              } else {
                                final key = keys.elementAt(
                                  pieTouchResponse
                                          ?.touchedSection
                                          ?.touchedSectionIndex ??
                                      0,
                                );
                                selectedTransactionsNotifier
                                    .updateSelectedTransactions(
                                      mappedHistory[key]!,
                                    );
                              }
                            },
                          ),
                          sectionsSpace: 8,
                          centerSpaceRadius: 90,
                          sections: chartPart,
                          startDegreeOffset: 0,
                        ),
                        curve: Curves.easeOutCubic,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${total > 0 ? "+" : ""}${formatter.format(total / 100)} €",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 84, 84),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        );
      },
    );
  }
}
