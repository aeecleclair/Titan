import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/admin/class/simple_group.dart';

class AnnouncerCard extends StatelessWidget {
  final SimpleGroup e;
  final HeroIcons icon;
  const AnnouncerCard({super.key, required this.e, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          HeroIcon(icon, size: 25, color: Colors.black),
        ],
      ),
    );
  }
}
