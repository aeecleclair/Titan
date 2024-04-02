import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class AdminPhCard extends StatelessWidget {
  final VoidCallback onEdit, onDelete;
  final Ph ph;
  const AdminPhCard({
    super.key,
    required this.ph,
    required this.onEdit,
    required this.onDelete,
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
              onTap: onEdit,
              child: CardButton(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade400,
                ],
                shadowColor: Colors.grey.shade300.withOpacity(0.2),
                child: const HeroIcon(HeroIcons.pencil, color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onDelete,
              child: CardButton(
                  colors: const [
                    Color(0xFF9E131F),
                    Color(0xFF590512),
                  ],
                  shadowColor: const Color(0xFF590512).withOpacity(0.2),
                  child: const HeroIcon(HeroIcons.trash, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
