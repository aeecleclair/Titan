import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';

class DateEntry extends StatelessWidget {
  final VoidCallback onTap;
  final String label, suffix, prefix;
  final bool canBeEmpty;
  final bool enabled;
  final TextEditingController controller;
  final Color color, enabledColor, errorColor;
  final Widget? suffixIcon;
  final GlobalKey<FormState>? formKey;
  final Function(String)? onChanged;
  final String? Function(String)? validator;

  const DateEntry(
      {super.key,
      required this.label,
      required this.controller,
      required this.onTap,
      this.onChanged,
      this.validator,
      this.formKey,
      this.prefix = '',
      this.suffix = '',
      this.enabled = true,
      this.canBeEmpty = false,
      this.color = Colors.black,
      this.enabledColor = Colors.black,
      this.errorColor = ColorConstants.error,
      this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: AbsorbPointer(
          child: Form(
            key: formKey,
            child: TextEntry(
              label: label,
              controller: controller,
              noValueError: TextConstants.noDateError,
              suffix: suffix,
              prefix: prefix,
              enabled: enabled,
              canBeEmpty: canBeEmpty,
              color: color,
              enabledColor: enabledColor,
              errorColor: errorColor,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
