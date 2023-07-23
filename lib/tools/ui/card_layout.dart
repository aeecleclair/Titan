import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {
  final Widget child;
  final double width, height;
  final Color color;
  final List<Color>? colors;
  final Color shadowColor;
  final Color? borderColor;
  const CardLayout(
      {super.key,
      required this.child,
      required this.width,
      required this.height,
      this.colors,
      this.color = Colors.white,
      this.shadowColor = const Color(0x80EEEEEE),
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.all(12.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: (colors == null || colors!.length > 1)
              ? null
              : RadialGradient(
                  colors: colors!,
                  center: Alignment.topLeft,
                  radius: 1.3,
                ),
          color: colors == null || colors!.length > 1 ? color : null,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: (colors == null || colors!.length > 1)
                  ? colors!.last.withOpacity(0.3)
                  : shadowColor,
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: child);
  }
}
