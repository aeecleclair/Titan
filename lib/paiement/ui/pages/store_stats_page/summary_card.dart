import 'package:flutter/widgets.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';

class SummaryCard extends StatelessWidget {
  final List<History> history;
  const SummaryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final allConfirmed =
        history.where((e) => e.status == TransactionStatus.confirmed);
    if (allConfirmed.isEmpty) {
      return const SizedBox();
    }

    final total = allConfirmed.fold(
      0,
      (previousValue, element) => previousValue + element.total,
    );
    final summaryTransactions = History(
      id: "",
      type: HistoryType.received,
      otherWalletName: "Total du mois",
      total: total,
      creation: history.first.creation,
      status: TransactionStatus.confirmed,
    );
    return TransactionCard(transaction: summaryTransactions);
  }
}
