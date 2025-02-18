import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/store.dart';

class StoreSellerCard extends StatelessWidget {
  final Store store;
  const StoreSellerCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundColor: Color.fromARGB(255, 6, 75, 75),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: AutoSizeText(
              store.name,
              maxLines: 2,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 29, 29),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: const HeroIcon(
              HeroIcons.arrowRight,
              color: Color.fromARGB(255, 0, 29, 29),
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
