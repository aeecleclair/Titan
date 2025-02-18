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
    final selectedTransactionsNotifier =
        ref.read(selectedTransactionsProvider.notifier);
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final Map<HistoryType, List<Color>> colors = {
      HistoryType.given: [
        const Color.fromARGB(255, 1, 127, 128),
        const Color.fromARGB(255, 0, 102, 103),
        const Color.fromARGB(255, 0, 44, 45).withOpacity(0.3),
      ],
      HistoryType.received: [
        const Color.fromARGB(255, 4, 84, 84),
        const Color.fromARGB(255, 0, 68, 68),
        const Color.fromARGB(255, 0, 29, 29).withOpacity(0.4),
      ],
      HistoryType.transfer: [
        const Color.fromARGB(255, 255, 119, 7),
        const Color.fromARGB(255, 230, 103, 0),
        const Color.fromARGB(255, 97, 44, 0).withOpacity(0.2),
      ],
    };
    final Map<HistoryType, Map<String, List<History>>> transactionPerType = {
      HistoryType.given: {},
      HistoryType.received: {},
      HistoryType.transfer: {},
    };

    return AsyncChild(
      value: history,
      builder: (context, history) {
        final confirmedTransaction = history.where(
          (element) =>
              element.status == TransactionStatus.confirmed &&
              element.creation.year == currentMonth.year &&
              element.creation.month == currentMonth.month,
        );
        for (final transaction in confirmedTransaction) {
          transactionPerType[transaction.type]![transaction.otherWalletName] = [
            ...?transactionPerType[transaction.type]![
                transaction.otherWalletName],
            transaction,
          ];
        }
        final List<PieChartSectionData> chartPart = [];
        final List<String> keys = [];
        final Map<String, List<History>> mappedHistory = {};
        double total = 0.0;

        for (final type in transactionPerType.keys) {
          for (final wallet in transactionPerType[type]!.keys) {
            final l = transactionPerType[type]![wallet]!;
            mappedHistory[type.name + wallet] = l;

            final totalAmount = l.fold<double>(
              0,
              (previousValue, element) => previousValue + element.total / 100,
            );
            if (type == HistoryType.given) {
              total -= totalAmount;
            } else {
              total += totalAmount;
            }
            keys.add(type.name + wallet);
            chartPart.add(
              PieChartSectionData(
                color: colors[type]![0],
                value: sqrt(totalAmount),
                title: '',
                radius: 60 +
                    (keys.indexOf(type.name + wallet) == selected.value
                        ? 15
                        : 0),
                badgePositionPercentageOffset: 0.6,
                badgeWidget: SumUpCard(
                  amount: '${formatter.format(totalAmount)} €',
                  color: colors[type]![0],
                  darkColor: colors[type]![1],
                  shadowColor: colors[type]![2],
                  title: wallet,
                ),
              ),
            );
          }
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
                              final newValue = pieTouchResponse
                                      ?.touchedSection?.touchedSectionIndex ??
                                  -1;
                              selected.value = newValue;
                              if (newValue == -1) {
                                selectedTransactionsNotifier
                                    .updateSelectedTransactions(
                                  confirmedTransaction.toList(),
                                );
                              } else {
                                final key = keys.elementAt(
                                  pieTouchResponse?.touchedSection
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
                        swapAnimationCurve: Curves.easeOutCubic,
                        swapAnimationDuration:
                            const Duration(milliseconds: 500),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${total > 0 ? "+" : ""}${formatter.format(total)} €",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 84, 84),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
