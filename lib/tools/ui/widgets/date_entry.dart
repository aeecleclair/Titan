import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class DateEntry extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool enabled;
  final TextEditingController controller;
  final Color color, enabledColor, errorColor;
  final Widget? suffixIcon;

  const DateEntry({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.enabled = true,
    this.color = Colors.black,
    this.enabledColor = Colors.black,
    this.errorColor = Colors.red,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextEntry(
          label: label,
          controller: controller,
          noValueError: TextConstants.noDateError,
          enabled: enabled,
          color: color,
          enabledColor: enabledColor,
          errorColor: errorColor,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
