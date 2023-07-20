import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String label, suffix;
  final bool isInt, isDouble;
  final bool canBeEmpty;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color color, enabledColor;
  final Function(String) onChanged;
  final String? Function(String) validator;
  static void noChange(String value) {}
  static String? noValidation(String value) => null;

  const TextEntry({
    Key? key,
    required this.label,
    required this.controller,
    this.onChanged = noChange,
    this.validator = noValidation,
    this.suffix = '',
    this.enabled = true,
    this.isInt = false,
    this.isDouble = false,
    this.keyboardType = TextInputType.text,
    this.canBeEmpty = false,
    this.color = Colors.black,
    this.enabledColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: color,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        suffix: Container(
          padding: const EdgeInsets.all(10),
          child: Text(suffix,
              style: const TextStyle(
                color: Colors.black,
              )),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: enabledColor)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.error)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
        ),
      ),
      validator: (value) {
        if (canBeEmpty) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return TextConstants.noValue;
        }
        if (!isInt) {
          return null;
        }
        final intValue = int.tryParse(value);
        if (intValue == null || intValue < 0) {
          return TextConstants.invalidNumber;
        }
        if (!isDouble) {
          return null;
        }
        final doubleValue = double.tryParse(value.replaceAll(',', '.'));
        if (doubleValue == null || doubleValue < 0) {
          return TextConstants.invalidNumber;
        }
        validator(value);
        return null;
      },
    );
  }
}
