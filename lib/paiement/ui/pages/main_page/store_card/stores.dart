import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/ui/pages/main_page/store_card/seller_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/store_card/store_divider.dart';

class Stores extends ConsumerWidget {
  const Stores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Gestion des stores",
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
        const StoreDivider(),
        const SellerCard(),
        const SellerCard(),
        const StoreDivider(),
        const SellerCard(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
