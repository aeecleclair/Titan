import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

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
        return ColorConstants.tertiary;
      case ButtonType.danger:
        return ColorConstants.main;
      case ButtonType.onDanger:
        return ColorConstants.onMain;
      case ButtonType.secondary:
        return ColorConstants.background;
    }
  }

  Color get borderColor {
    switch (type) {
      case ButtonType.main:
        return ColorConstants.onTertiary;
      case ButtonType.danger:
        return ColorConstants.mainBorder;
      case ButtonType.onDanger:
        return ColorConstants.mainBorder;
      case ButtonType.secondary:
        return ColorConstants.onBackground;
    }
  }

  Color get textColor {
    Color color;
    switch (type) {
      case ButtonType.main:
        color = ColorConstants.background;
      case ButtonType.onDanger:
        color = ColorConstants.background;
      case ButtonType.danger:
        color = ColorConstants.background;
      case ButtonType.secondary:
        color = ColorConstants.tertiary;
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
