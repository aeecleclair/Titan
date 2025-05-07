import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/my_history_provider.dart';
import 'package:myecl/paiement/ui/pages/stats_page/month_bar.dart';
import 'package:myecl/paiement/ui/pages/stats_page/sum_up_chart.dart';
import 'package:myecl/paiement/ui/pages/stats_page/transactions_detail.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class StatsPage extends HookConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myHistoryNotifier = ref.read(myHistoryProvider.notifier);
    return PaymentTemplate(
      child: LayoutBuilder(
        builder: (context, constraints) => Refresher(
          onRefresh: () async {
            await myHistoryNotifier.getHistory();
          },
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                MonthBar(),
                SizedBox(
                  height: 80,
                ),
                SumUpChart(),
                SizedBox(
                  height: 50,
                ),
                TransactionsDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
