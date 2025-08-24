import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class DateEntry extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool enabled, canBeEmpty;
  final TextEditingController controller;
  final Color color, enabledColor, errorColor;
  final Widget? suffixIcon;

  const DateEntry({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.enabled = true,
    this.canBeEmpty = false,
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
          noValueError: AppLocalizations.of(context)!.toolDateRequired,
          enabled: enabled,
          color: color,
          enabledColor: enabledColor,
          errorColor: errorColor,
          suffixIcon: suffixIcon,
          canBeEmpty: canBeEmpty,
        ),
      ),
    );
  }
}
