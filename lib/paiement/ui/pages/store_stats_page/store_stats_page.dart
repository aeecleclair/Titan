import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/selected_interval_provider.dart';
import 'package:titan/paiement/providers/selected_store_provider.dart';
import 'package:titan/paiement/ui/pages/store_stats_page/interval_selector.dart';
import 'package:titan/paiement/ui/pages/store_stats_page/store_transactions_detail.dart';
import 'package:titan/paiement/ui/pages/store_stats_page/summary_card.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/paiement/providers/selected_store_history.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class StoreStatsPage extends ConsumerWidget {
  const StoreStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedHistory = ref.watch(sellerHistoryProvider);
    final selectedHistoryNotifier = ref.read(sellerHistoryProvider.notifier);
    final selectedInterval = ref.watch(selectedIntervalProvider);
    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {
          await selectedHistoryNotifier.getHistory(
            selectedStore.id,
            selectedInterval.start,
            selectedInterval.end,
          );
        },
        child: AsyncChild(
          value: selectedHistory,
          builder: (context, history) {
            final sortedByDate = history.toList()
              ..sort((a, b) => a.creation.compareTo(b.creation));
            return Column(
              children: [
                const SizedBox(height: 20),
                const IntervalSelector(),
                const SizedBox(height: 20),
                SummaryCard(history: sortedByDate),
                const SizedBox(height: 20),
                StoreTransactionsDetail(history: sortedByDate),
              ],
            );
          },
        ),
      ),
    );
  }
}
