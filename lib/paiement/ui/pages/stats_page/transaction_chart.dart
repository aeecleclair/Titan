import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/providers/selected_transactions_provider.dart';
import 'package:titan/paiement/tools/functions.dart';
import 'package:titan/paiement/ui/pages/stats_page/sum_up_card.dart';
import 'package:titan/tools/providers/locale_notifier.dart';

class TransactionChart extends HookConsumerWidget {
  final Map<String, List<History>> transactionPerStore;
  final DateTime currentMonth;
  const TransactionChart({
    super.key,
    required this.transactionPerStore,
    required this.currentMonth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final selected = useState(-1);
    final List<PieChartSectionData> chartPart = [];

    final selectedTransactionsNotifier = ref.read(
      selectedTransactionsProvider(currentMonth).notifier,
    );
    final Map<String, List<History>> mappedHistory = {};
    final List<String> keys = [];
    final formatter = NumberFormat.currency(locale: locale.toString(), symbol: "€");

    for (final (index, wallet) in transactionPerStore.keys.indexed) {
      final l = transactionPerStore[wallet]!;
      mappedHistory[wallet] = l;

      final totalAmount = l.fold<int>(
        0,
        (previousValue, element) => previousValue + element.total,
      );
      keys.add(wallet);
      final baseColors = getTransactionColors(l.first);
      List<Color> walletColor = baseColors;
      if (index > 0) {
        walletColor = generateColorVariations(baseColors, wallet);
      }
      chartPart.add(
        PieChartSectionData(
          color: walletColor[0],
          value: (totalAmount / 100).abs(),
          title: '',
          radius: 40 + (keys.indexOf(wallet) == selected.value ? 10 : 0),
          badgePositionPercentageOffset: 0.6,
          badgeWidget: SumUpCard(
            amount: formatter.format(totalAmount / 100),
            color: walletColor[0],
            darkColor: walletColor[1],
            shadowColor: walletColor[2],
            title: wallet,
          ),
        ),
      );
    }

    return chartPart.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.paiementNoTransaction,
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
          )
        : PieChart(
            PieChartData(
              borderData: FlBorderData(show: true),
              pieTouchData: PieTouchData(
                touchCallback: (flTouchEvent, pieTouchResponse) {
                  final newValue =
                      pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                      -1;
                  selected.value = newValue;
                  if (newValue == -1) {
                    selectedTransactionsNotifier.updateSelectedTransactions(
                      transactionPerStore.values.expand((e) => e).toList(),
                    );
                  } else {
                    final key = keys.elementAt(
                      pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                          0,
                    );
                    selectedTransactionsNotifier.updateSelectedTransactions(
                      mappedHistory[key]!,
                    );
                  }
                },
              ),
              sectionsSpace: 5,
              centerSpaceRadius: 60,
              sections: chartPart,
              startDegreeOffset: 0,
            ),
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 500),
          );
  }
}
