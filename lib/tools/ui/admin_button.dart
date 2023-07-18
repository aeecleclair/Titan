import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';

class AdminButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color? gradientColor;
  const AdminButton(
      {super.key,
      required this.onTap,
      this.textColor = Colors.white,
      this.backgroundColor = Colors.black,
      this.gradientColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                backgroundColor,
                gradientColor ?? backgroundColor,
              ],
              center: Alignment.topLeft,
              radius: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: (gradientColor ?? backgroundColor).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ]),
        child: Row(
          children: [
            HeroIcon(HeroIcons.userGroup, color: textColor),
            const SizedBox(width: 10),
            Text(TextConstants.admin,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
          ],
        ),
      ),
    );
  }
}
