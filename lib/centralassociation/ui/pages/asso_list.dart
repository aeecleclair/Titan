import 'package:flutter/material.dart';
import 'package:titan/centralassociation/class/asso.dart';
import 'package:titan/centralassociation/ui/pages/link_card.dart';

class AssoList extends StatelessWidget {
  final Asso asso;
  const AssoList({super.key, required this.asso});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            asso.name,
            style: const TextStyle(fontSize: 23, fontWeight: .w900),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: .start,
            children: asso.linkList
                .map((link) => LinkCard(link: link))
                .toList(),
          ),
        ],
      ),
    );
  }
}
