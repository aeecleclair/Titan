import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/ui/pages/stats_page/month_bar.dart';
import 'package:titan/paiement/ui/pages/stats_page/sum_up_chart.dart';
import 'package:titan/paiement/ui/pages/stats_page/transactions_detail.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class StatsPage extends HookConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myHistoryNotifier = ref.read(myHistoryProvider.notifier);
    final pageController = usePageController();
    final now = DateTime.now();
    return PaymentTemplate(
      child: LayoutBuilder(
        builder: (context, constraints) => Refresher(
          controller: ScrollController(),
          onRefresh: () async {
            await myHistoryNotifier.getHistory();
          },
          child: SizedBox(
            height: constraints.maxHeight,
            child: PageView.builder(
              itemBuilder: (context, index) {
                final month = DateTime(
                  now.year,
                  now.month - index,
                  1,
                ).toLocal();
                return Column(
                  children: [
                    SizedBox(height: 20),
                    MonthBar(currentMonth: month),
                    SizedBox(height: 5),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            SumUpChart(currentMonth: month),
                            SizedBox(height: 20),
                            TransactionsDetail(currentMonth: month),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              controller: pageController,
              reverse: true,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
