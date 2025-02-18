import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/transaction.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/ui/components/transaction_card.dart';
import 'package:myecl/paiement/ui/pages/store_stats_page/refund_page.dart';

class StoreTransactionsDetail extends ConsumerWidget {
  final List<History> history;
  const StoreTransactionsDetail({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStore = ref.watch(selectedStoreProvider);

    void showCancelModal(History history) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio:
            (1 - 80 / MediaQuery.of(context).size.height),
        builder: (context) => ReFundPage(history: history),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: history
              .map(
                (e) => TransactionCard(
                  transaction: e,
                  onTap: () => {
                    if (selectedStore.canCancel &&
                        e.status == TransactionStatus.confirmed)
                      {
                        showCancelModal(e),
                      },
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
