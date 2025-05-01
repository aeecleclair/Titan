import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';

class AdminButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? textColor;
  final Color? color;
  final List<Color>? colors;
  final String text;
  const AdminButton({
    super.key,
    required this.onTap,
    this.textColor,
    this.color,
    this.text = TextConstants.admin,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final useColors = colors != null && colors!.length > 1;
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
          color: useColors
              ? null
              : color ?? Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            HeroIcon(
              HeroIcons.userGroup,
              color: textColor ?? Theme.of(context).colorScheme.onSecondary,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
