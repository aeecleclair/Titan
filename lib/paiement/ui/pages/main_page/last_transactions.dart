import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/history_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/day_divider.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';

class LastTransactions extends ConsumerWidget {
  const LastTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Dernières transactions",
            style: TextStyle(
              color: Color(0xff204550),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const DayDivider(),
        const TransactionCard(),
        const TransactionCard(),
        const DayDivider(),
        const TransactionCard(),
        const DayDivider(),
        const TransactionCard(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
