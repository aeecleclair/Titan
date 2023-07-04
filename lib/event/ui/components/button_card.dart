import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ButtonCard extends StatelessWidget {
  final Color backGroundColor;
  final HeroIcon icon;
  final VoidCallback onTap;
  final Border border;
  const ButtonCard(
      {super.key,
      required this.backGroundColor,
      required this.icon,
      required this.onTap,
      this.border = const Border.fromBorderSide(BorderSide.none)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(30),
          border: border,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 3))
          ],
        ),
        child: icon,
      ),
    );
  }
}
