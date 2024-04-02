import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class PhCard extends StatelessWidget {
  final Ph ph;
  final VoidCallback onView;
  const PhCard({
    super.key,
    required this.ph,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CardLayout(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Nom : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(ph.name, 28)),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Date de publication : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(phFormatDate(ph.date)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onView,
              child: CardButton(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade400,
                ],
                shadowColor: Colors.grey.shade300.withOpacity(0.2),
                child: const HeroIcon(HeroIcons.eye, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
