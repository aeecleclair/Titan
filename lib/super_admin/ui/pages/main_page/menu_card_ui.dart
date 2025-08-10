import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MenuCardUi extends StatelessWidget {
  final String text;
  final HeroIcons icon;
  const MenuCardUi({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeroIcon(icon, color: Colors.grey.shade700, size: 40),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
