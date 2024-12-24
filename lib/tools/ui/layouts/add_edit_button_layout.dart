import 'package:flutter/material.dart';

class AddEditButtonLayout extends StatelessWidget {
  final Widget child;
  final Color? color;
  final List<Color>? colors;
  const AddEditButtonLayout({
    super.key,
    required this.child,
    this.color,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final useColors = colors != null && colors!.length > 1;
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: useColors
            ? RadialGradient(
                colors: colors!,
                center: Alignment.topLeft,
                radius: 1.3,
              )
            : null,
        color:
            useColors ? null : color ?? Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
