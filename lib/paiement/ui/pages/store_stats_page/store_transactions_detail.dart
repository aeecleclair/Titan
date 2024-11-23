import 'package:flutter/material.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';

class StoreTransactionsDetail extends StatelessWidget {
  final List<History> history;
  const StoreTransactionsDetail({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: history
              .map(
                (e) => TransactionCard(
                  transaction: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
