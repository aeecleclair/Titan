import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/seller_divider.dart';
import 'package:myecl/paiement/ui/pages/main_page/transaction_card.dart';

class Sellers extends ConsumerWidget {
  const Sellers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Gestion des sellers",
            style: TextStyle(
              color: Color.fromARGB(255, 199, 90, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // const SellerDivider(),
        // const TransactionCard(),
        // const TransactionCard(),
        const SellerDivider(),
        // const TransactionCard(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
