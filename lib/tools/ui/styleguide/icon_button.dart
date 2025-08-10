import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

enum CustomIconButtonType { main, danger, secondary }

class CustomIconButton extends StatelessWidget {
  final CustomIconButtonType type;
  final Widget icon;
  final bool? disabled;
  final Function() onPressed;

  const CustomIconButton({
    super.key,
    this.type = CustomIconButtonType.main,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  });

  const CustomIconButton.danger({
    super.key,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  }) : type = CustomIconButtonType.danger;

  const CustomIconButton.secondary({
    super.key,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  }) : type = CustomIconButtonType.secondary;

  Color get backgroundColor {
    switch (type) {
      case CustomIconButtonType.main:
        return ColorConstants.tertiary;
      case CustomIconButtonType.danger:
        return ColorConstants.main;
      case CustomIconButtonType.secondary:
        return ColorConstants.background;
    }
  }

  Color get borderColor {
    switch (type) {
      case CustomIconButtonType.main:
        return ColorConstants.onTertiary;
      case CustomIconButtonType.danger:
        return ColorConstants.mainBorder;
      case CustomIconButtonType.secondary:
        return ColorConstants.onBackground;
    }
  }

  Color get textColor {
    Color color;
    switch (type) {
      case CustomIconButtonType.main:
        color = ColorConstants.background;
      case CustomIconButtonType.danger:
        color = ColorConstants.background;
      case CustomIconButtonType.secondary:
        color = ColorConstants.tertiary;
    }
    if (disabled == true) {
      return color.withAlpha(150);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return WaitingButton(
      onTap: disabled == true ? null : () async => onPressed(),
      builder: (child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: child,
      ),
      child: Center(child: icon),
    );
  }
}
