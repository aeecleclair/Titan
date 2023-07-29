import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color? gradient;
  final Color? shadowColor;
  final Border border;
  const CardButton(
      {super.key,
      required this.child,
      required this.color,
      this.gradient,
      this.shadowColor,
      this.border = const Border.fromBorderSide(BorderSide.none)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [color, gradient ?? color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: border,
        boxShadow: [
          BoxShadow(
              color: shadowColor ?? (gradient ?? color).withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 3))
        ],
      ),
      child: child,
    );
  }
}
