import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final List<Color>? colors;
  final Color? shadowColor;
  final Color? borderColor;
  final double? size;
  final BorderRadiusGeometry? borderRadius;
  const CardButton({
    super.key,
    required this.child,
    this.color,
    this.colors,
    this.shadowColor,
    this.borderColor,
    this.size = 40,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  Widget build(BuildContext context) {
    final useColors = colors != null && colors!.length > 1;
    final useShadow = !useColors ||
        (useColors && colors!.last == Theme.of(context).colorScheme.primary);
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? Theme.of(context).colorScheme.secondaryFixed,
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
            color: (useShadow
                    ? shadowColor
                    : colors!.last.withValues(alpha: 0.5)) ??
                Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
