import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class PictureButton extends StatelessWidget {
  final HeroIcons icon;
  const PictureButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryFixed
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primaryFixed.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: HeroIcon(
        icon,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
