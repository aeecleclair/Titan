import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/selected_transactions_provider.dart';
import 'package:titan/paiement/ui/components/transaction_card.dart';

class TransactionsDetail extends ConsumerWidget {
  final DateTime currentMonth;
  const TransactionsDetail({super.key, required this.currentMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHistory = ref.watch(
      selectedTransactionsProvider(currentMonth),
    );
    final sortedByDate = selectedHistory
      ..sort((a, b) => b.creation.compareTo(a.creation));
    return Column(
      children: sortedByDate
          .map((e) => TransactionCard(transaction: e))
          .toList(),
    );
  }
}
