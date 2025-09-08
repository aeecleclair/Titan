import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/providers/selected_transactions_provider.dart';
import 'package:titan/paiement/ui/pages/stats_page/month_section_summary.dart';
import 'package:titan/paiement/ui/pages/stats_page/transaction_chart.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class SumUpChart extends HookConsumerWidget {
  final DateTime currentMonth;
  const SumUpChart({super.key, required this.currentMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(-1);
    final history = ref.watch(myHistoryProvider);
    final pageController = usePageController();
    final selectedTransactionsNotifier = ref.read(
      selectedTransactionsProvider(currentMonth).notifier,
    );
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final Map<String, List<History>> transactionPerStore = {};
    final Map<String, List<History>> creditedTransactionPerStore = {};

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
          if (transaction.type == HistoryType.transfer ||
              transaction.type == HistoryType.refundCredited) {
            final transactionName = transaction.type != HistoryType.transfer
                ? transaction.otherWalletName
                : "Recharge";
            creditedTransactionPerStore[transactionName] = [
              ...?creditedTransactionPerStore[transactionName],
              transaction,
            ];
          } else {
            transactionPerStore[transaction.otherWalletName] = [
              ...?transactionPerStore[transaction.otherWalletName],
              transaction,
            ];
          }
        }
        int total = 0;
        int transferTotal = 0;

        for (final wallet in transactionPerStore.keys) {
          final l = transactionPerStore[wallet]!;
          final totalAmount = l.fold<int>(
            0,
            (previousValue, element) => previousValue + element.total,
          );
          total += totalAmount;
        }

        for (final wallet in creditedTransactionPerStore.keys) {
          final l = creditedTransactionPerStore[wallet]!;
          final totalAmount = l.fold<int>(
            0,
            (previousValue, element) => previousValue + element.total,
          );
          transferTotal += totalAmount;
        }

        return confirmedTransaction.isNotEmpty
            ? Stack(
                children: [
                  SizedBox(
                    height: 345,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: pageController,
                            clipBehavior: Clip.none,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              TransactionChart(
                                currentMonth: currentMonth,
                                transactionPerStore:
                                    creditedTransactionPerStore,
                              ),
                              TransactionChart(
                                currentMonth: currentMonth,
                                transactionPerStore: transactionPerStore,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selected.value = -1;
                                selectedTransactionsNotifier
                                    .updateSelectedTransactions(
                                      confirmedTransaction.toList(),
                                    );
                                pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                );
                              },
                              child: MonthSectionSummary(
                                title: "Reçu",
                                amount:
                                    '${formatter.format(transferTotal / 100)} €',
                                color: const Color.fromARGB(255, 255, 119, 7),
                                darkColor: const Color.fromARGB(
                                  255,
                                  230,
                                  103,
                                  0,
                                ),
                                shadowColor: const Color.fromARGB(
                                  255,
                                  97,
                                  44,
                                  0,
                                ).withValues(alpha: 0.2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selected.value = -1;
                                selectedTransactionsNotifier
                                    .updateSelectedTransactions(
                                      confirmedTransaction.toList(),
                                    );
                                pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                );
                              },
                              child: MonthSectionSummary(
                                title: "Déboursé",
                                amount: '${formatter.format(total / 100)} €',
                                color: const Color.fromARGB(255, 1, 127, 128),
                                darkColor: const Color.fromARGB(
                                  255,
                                  0,
                                  102,
                                  103,
                                ),
                                shadowColor: const Color.fromARGB(
                                  255,
                                  0,
                                  44,
                                  45,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                height: 300,
                alignment: Alignment.center,
                child: const Text(
                  "Aucune transaction pour ce mois",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
      },
    );
  }
}
