import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final List<Color>? colors;
  final Color shadowColor;
  final Color? borderColor;
  const CardButton(
      {super.key,
      required this.child,
      this.color = const Color(0xFFEEEEEE),
      this.colors,
      this.shadowColor = const Color(0x339E9E9E),
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    final useColors = colors != null && colors!.length > 1;
    final useShadow = !useColors || (useColors && colors!.last == Colors.white);
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        gradient: useColors
            ? RadialGradient(
                colors: colors!,
                center: Alignment.topLeft,
                radius: 1.3,
              )
            : null,
        border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
        boxShadow: [
          BoxShadow(
              color: (useShadow || !useColors)
                  ? shadowColor
                  : colors!.last.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 3))
        ],
      ),
      child: child,
    );
  }
}
