import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String label, suffix, prefix, noValueError;
  final bool isInt, isDouble, isNegative;
  final bool canBeEmpty;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Color color, enabledColor, errorColor;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String)? validator;
  final int? minLines, maxLines;
  final TextInputAction textInputAction;

  const TextEntry({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.validator,
    this.minLines,
    this.maxLines,
    this.prefix = '',
    this.suffix = '',
    this.enabled = true,
    this.isInt = false,
    this.isDouble = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.canBeEmpty = false,
    this.color = ColorConstants.onTertiary,
    this.enabledColor = ColorConstants.onTertiary,
    this.errorColor = ColorConstants.main,
    this.noValueError = "No value",
    this.suffixIcon,
    this.isNegative = false,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final localizeWithContext = AppLocalizations.of(context)!;

    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      cursorColor: color,
      onChanged: onChanged,
      textInputAction: (keyboardType == TextInputType.multiline)
          ? TextInputAction.newline
          : textInputAction,
      enabled: enabled,
      decoration: InputDecoration(
        label: Text(
          canBeEmpty ? localizeWithContext.globalOptionnal(label) : label,
          style: TextStyle(color: color, height: 0.5),
        ),
        suffixIcon: suffixIcon,
        suffix: suffixIcon == null && suffix.isEmpty
            ? null
            : (suffixIcon == null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(suffix, style: TextStyle(color: color)),
                    )
                  : null),
        prefix: prefix.isEmpty
            ? null
            : Container(
                padding: const EdgeInsets.only(right: 10),
                child: Text(prefix, style: TextStyle(color: color)),
              ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: enabledColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (canBeEmpty) {
            return null;
          }
          return noValueError;
        }

        if (isInt) {
          final intValue = int.tryParse(value);
          if (intValue == null || (intValue < 0 && !isNegative)) {
            return localizeWithContext.toolInvalidNumber;
          }
        }

        if (isDouble) {
          final doubleValue = double.tryParse(value.replaceAll(',', '.'));
          if (doubleValue == null || (doubleValue < 0 && !isNegative)) {
            return localizeWithContext.toolInvalidNumber;
          }
        }

        if (validator == null) {
          return null;
        }
        return validator!(value);
      },
    );
  }
}
