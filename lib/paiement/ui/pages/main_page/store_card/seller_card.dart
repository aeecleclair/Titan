import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundColor: Color.fromARGB(255, 230, 103, 0),
          ),
          const SizedBox(
            width: 15,
          ),
          const Expanded(
            child: AutoSizeText(
              "WEI",
              maxLines: 2,
              style: TextStyle(
                color: Color.fromARGB(255, 199, 90, 1),
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
              color: Color.fromARGB(255, 199, 90, 1),
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
