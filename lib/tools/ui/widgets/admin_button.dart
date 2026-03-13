import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';
import 'package:flutter/widget_previews.dart';

class AdminButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color textColor;
  final Color? color;
  final List<Color>? colors;
  final String text;
  const AdminButton({
    super.key,
    required this.onTap,
    this.textColor = Colors.white,
    this.color = Colors.black,
    this.text = TextConstants.admin,
    this.colors,
  });

  @Preview(name: "Truc", brightness: .light, size: Size(500, 500))
  static Widget truc() {
    return Center(
      child: AdminButton(onTap: () {}, text: "Yo"),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              color: (useColors ? colors!.last : color)!.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            HeroIcon(HeroIcons.userGroup, color: textColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
