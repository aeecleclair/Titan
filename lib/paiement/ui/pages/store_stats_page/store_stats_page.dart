import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/ui/pages/stats_page/month_bar.dart';
import 'package:myecl/paiement/ui/pages/store_stats_page/store_transactions_detail.dart';
import 'package:myecl/paiement/ui/pages/store_stats_page/summary_card.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';
import 'package:myecl/paiement/providers/selected_store_history.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class StoreStatsPage extends ConsumerWidget {
  const StoreStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHistory = ref.watch(sellerHistoryProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    return AsyncChild(
      value: selectedHistory,
      builder: (context, history) {
        final sortedByDate = history
            .where(
              (element) =>
                  element.creation.month == selectedMonth.month &&
                  element.creation.year == selectedMonth.year,
            )
            .toList()
          ..sort((a, b) => a.creation.compareTo(b.creation));
        return PaymentTemplate(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const MonthBar(),
              const SizedBox(
                height: 30,
              ),
              StoreTransactionsDetail(
                history: sortedByDate,
              ),
              const SizedBox(
                height: 20,
              ),
              SummaryCard(history: sortedByDate),
            ],
          ),
        );
      },
    );
  }
}