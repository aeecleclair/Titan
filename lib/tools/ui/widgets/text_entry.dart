import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String label, suffix, prefix, noValueError;
  final bool isInt, isDouble;
  final bool canBeEmpty;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color color, enabledColor, errorColor;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String)? validator;
  final int? minLines, maxLines;

  const TextEntry(
      {super.key,
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
      this.canBeEmpty = false,
      this.color = Colors.black,
      this.enabledColor = Colors.black,
      this.errorColor = ColorConstants.error,
      this.noValueError = TextConstants.noValue,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: color,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      enabled: enabled,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(color: color, height: 0.5),
        ),
        suffix: suffixIcon == null && suffix.isEmpty
            ? null
            : Container(
                padding: const EdgeInsets.only(left: 10),
                child:
                    suffixIcon ?? Text(suffix, style: TextStyle(color: color)),
              ),
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
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: enabledColor)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 2.0)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
        ),
      ),
      validator: (value) {
        if (canBeEmpty) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return noValueError;
        }
        final intValue = int.tryParse(value);
        if (isInt && (intValue == null || intValue < 0)) {
          return TextConstants.invalidNumber;
        }
        final doubleValue = double.tryParse(value.replaceAll(',', '.'));
        if (isDouble && (doubleValue == null || doubleValue < 0)) {
          return TextConstants.invalidNumber;
        }
        validator?.call(value);
        return null;
      },
    );
  }
}
