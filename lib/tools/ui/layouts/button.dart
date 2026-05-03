import 'package:flutter/material.dart';

enum ButtonType { main, danger, onDanger, secondary }

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

  const Button.onDanger({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
  }) : type = ButtonType.onDanger;

  const Button.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
  }) : type = ButtonType.secondary;

  Color get backgroundColor {
    switch (type) {
      case ButtonType.main:
        return Color(0xFF424242);
      case ButtonType.danger:
        return Color(0xFFfb6d10);
      case ButtonType.onDanger:
        return Color(0xffeb3e1b);
      case ButtonType.secondary:
        return Color(0xFFffffff);
    }
  }

  Color get borderColor {
    switch (type) {
      case ButtonType.main:
        return Color(0xFF212121);
      case ButtonType.danger:
        return Color.fromARGB(255, 87, 3, 3);
      case ButtonType.onDanger:
        return Color.fromARGB(255, 87, 3, 3);
      case ButtonType.secondary:
        return Color(0xffb4b4b4);
    }
  }

  Color get textColor {
    Color color;
    switch (type) {
      case ButtonType.main:
        color = Color(0xFFffffff);
      case ButtonType.onDanger:
        color = Color(0xFFffffff);
      case ButtonType.danger:
        color = Color(0xFFffffff);
      case ButtonType.secondary:
        color = Color(0xFF424242);
    }
    if (disabled == true) {
      return color.withAlpha(150);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled == true ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
