import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String label, suffix;
  final bool isInt;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const TextEntry(
      {Key? key,
      required this.label,
      required this.suffix,
      required this.isInt,
      required this.controller,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: label,
        suffix: Text(suffix, style: const TextStyle(color: Colors.black)),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
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
