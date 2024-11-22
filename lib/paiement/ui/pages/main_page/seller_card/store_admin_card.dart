import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class StoreAdminCard extends StatelessWidget {
  const StoreAdminCard({super.key});

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
          const Expanded(
            child: AutoSizeText(
              "Gestion des admins",
              maxLines: 2,
              style: TextStyle(
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
