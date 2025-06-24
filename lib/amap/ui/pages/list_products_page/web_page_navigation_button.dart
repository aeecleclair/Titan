import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/amap/tools/constants.dart';

class WebPageNavigationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final HeroIcons icon;
  const WebPageNavigationButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AMAPColorConstants.enabled,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AMAPColorConstants.enabled.withValues(alpha: 0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: HeroIcon(icon, size: 25, color: Colors.white),
      ),
    );
  }
}
