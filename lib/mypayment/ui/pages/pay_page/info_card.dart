import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class InfoCard extends StatelessWidget {
  final HeroIcons icons;
  final String title;
  final String value;
  const InfoCard({
    super.key,
    required this.icons,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            HeroIcon(icons, color: Colors.black, size: 35),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 13)),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
