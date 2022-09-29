import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String label, suffix;
  final bool isInt;
  final TextEditingController controller;
  const TextEntry(
      {Key? key,
      required this.label,
      required this.suffix,
      required this.isInt,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffix: Text(suffix),
      ),
      validator: (value) {
        if (value == null) {
          return LoanTextConstants.noValue;
        } else if (value.isEmpty) {
          return LoanTextConstants.noValue;
        } else if (isInt) {
          if (int.tryParse(value) == null) {
            return LoanTextConstants.invalidNumber;
          } else if (int.parse(value) < 0) {
            return LoanTextConstants.positiveNumber;
          }
        }
        return null;
      },
    );
  }
}
