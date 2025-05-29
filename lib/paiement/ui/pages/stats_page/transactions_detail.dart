import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/selected_transactions_provider.dart';
import 'package:myecl/paiement/ui/components/transaction_card.dart';

class TransactionsDetail extends ConsumerWidget {
  const TransactionsDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHistory = ref.watch(selectedTransactionsProvider);
    final sortedByDate = selectedHistory
      ..sort((a, b) => b.creation.compareTo(a.creation));
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: sortedByDate
              .map((e) => TransactionCard(transaction: e))
              .toList(),
        ),
      ),
    );
  }
}
