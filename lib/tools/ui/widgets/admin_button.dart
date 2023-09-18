import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';

class AdminButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color textColor;
  final Color? color;
  final List<Color>? colors;
  const AdminButton(
      {super.key,
      required this.onTap,
      this.textColor = Colors.white,
      this.color = Colors.black,
      this.colors});

  @override
  Widget build(BuildContext context) {
    assert(color != null || (colors != null && colors!.length > 1));
    final useColors = colors != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            gradient: useColors
                ? RadialGradient(
                    colors: colors!,
                    center: Alignment.topLeft,
                    radius: 2,
                  )
                : null,
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: (useColors ? colors!.last : color)!.withOpacity(0.2),
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
