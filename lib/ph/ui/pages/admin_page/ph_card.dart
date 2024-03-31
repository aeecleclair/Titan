import 'package:flutter/material.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class PhCard extends StatelessWidget {
  final Ph ph;
  const PhCard({
    super.key,
    required this.ph,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CardLayout(
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Nom : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(ph.name),
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
      ),
    );
  }
}
