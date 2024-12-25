import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final EdgeInsets? margin;

  const MyButton({
    super.key,
    required this.text,
    this.enabled = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 30),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: enabled
              ? [
                  Theme.of(context).colorScheme.primaryFixed,
                  Theme.of(context).colorScheme.primaryContainer,
                ]
              : [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.tertiary,
                ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: enabled
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurface,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
