import 'package:flutter/material.dart';

enum ButtonType { main, danger, secondary }

class Button extends StatelessWidget {
  final ButtonType type;
  final String text;
  final bool? disabled;
  final double? fontSize;
  final Function() onPressed;

  const Button({
    super.key,
    this.type = ButtonType.main,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
  });

  const Button.danger({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
  }) : type = ButtonType.danger;

  const Button.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
  }) : type = ButtonType.secondary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled == true ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: switch (type) {
            .main => Theme.of(context).colorScheme.secondaryContainer,
            .danger => Theme.of(context).colorScheme.primaryContainer,
            .secondary => Theme.of(context).colorScheme.secondaryFixed,
          },
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: switch (type) {
              .main => Theme.of(context).colorScheme.tertiary,
              .danger => Theme.of(context).colorScheme.primaryFixed,
              .secondary => Theme.of(context).colorScheme.tertiary,
            },
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabled == true
                  ? Theme.of(context).colorScheme.tertiary
                  : switch (type) {
                      .main => Theme.of(context).colorScheme.secondaryFixed,
                      .danger => Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                      .secondary => Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                    },
              fontSize: fontSize ?? 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
