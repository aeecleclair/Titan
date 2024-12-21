import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final Color color;
  final List<Color>? colors;
  final Color shadowColor;
  final Color? borderColor;
  final String? id;
  final EdgeInsetsGeometry padding, margin;
  final BorderRadiusGeometry? borderRadius;
  const CardLayout({
    super.key,
    required this.child,
    this.id,
    this.width,
    this.height,
    this.colors,
    this.color = Colors.white,
    this.shadowColor = const Color(0x80EEEEEE),
    this.borderColor,
    this.padding = const EdgeInsets.all(12.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 15.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
  });

  @override
  Widget build(BuildContext context) {
    final useColors = colors != null && colors!.length > 1;
    final useShadow = !useColors || (useColors && colors!.last == Colors.white);
    return Hero(
      tag: id ?? UniqueKey(),
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: useColors
              ? RadialGradient(
                  colors: colors!,
                  center: Alignment.topLeft,
                  radius: 1.3,
                )
              : null,
          color: useColors ? null : color,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: (useShadow || !useColors)
                  ? shadowColor
                  : colors!.last.withValues(alpha: 0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
