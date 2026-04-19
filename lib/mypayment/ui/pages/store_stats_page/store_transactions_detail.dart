import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/providers/refund_amount_provider.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/ui/components/transaction_card.dart';
import 'package:titan/mypayment/ui/pages/store_stats_page/refund_page.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';

class StoreTransactionsDetail extends HookConsumerWidget {
  final List<History> history;
  const StoreTransactionsDetail({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStore = ref.watch(selectedStoreProvider);
    final refundAmountNotifier = ref.watch(refundAmountProvider.notifier);
    final scrollController = useMemoized(() => ScrollController(), []);

    void showCancelModal(History history) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio:
            (1 - 80 / MediaQuery.of(context).size.height),
        builder: (context) => ReFundPage(history: history),
      ).then((_) {
        refundAmountNotifier.setRefundAmount("");
      });
    }

    history.sort((a, b) => b.creation.compareTo(a.creation));

    return ScrollToHideNavbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: history
              .map(
                (t) => TransactionCard(
                  transaction: t,
                  onTap: () => {
                    if (selectedStore.canCancel &&
                        t.status == TransactionStatus.confirmed &&
                        t.type == HistoryType.directTransaction &&
                        t.direction == HistoryDirection.credited)
                      {showCancelModal(t)},
                  },
                  storeView: true,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
