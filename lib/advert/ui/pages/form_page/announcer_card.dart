import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class AdvertiserCard extends StatelessWidget {
  final CoreGroupSimple e;
  final HeroIcons icon;
  const AdvertiserCard({super.key, required this.e, required this.icon});

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
          HeroIcon(icon, size: 25, color: Colors.black)
        ],
      ),
    );
  }
}
