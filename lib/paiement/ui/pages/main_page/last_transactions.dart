import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';

class LastTransactions extends StatelessWidget {
  const LastTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text("Dernières transactions",
              style: TextStyle(
                  color: Color(0xff204550),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        const TransactionCard(),
        const TransactionCard(),
        const TransactionCard(),
      ],
    );
  }
}
