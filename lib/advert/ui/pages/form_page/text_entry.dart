import 'package:flutter/material.dart';
import 'package:myecl/advert/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final int minLines, maxLines;
  final String label, suffix;
  final bool isInt;
  final bool canBeEmpty;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(dynamic) onChanged;
  const TextEntry(
      {Key? key,
      required this.label,
      required this.suffix,
      required this.isInt,
      required this.controller,
      required this.keyboardType,
      required this.onChanged,
      this.canBeEmpty = false,
      required this.minLines,
      required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
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
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (!canBeEmpty) {
          if (value == null) {
            return AdvertTextConstants.noValue;
          } else if (value.isEmpty) {
            return AdvertTextConstants.noValue;
          } else if (isInt) {
            if (int.tryParse(value) == null) {
              return AdvertTextConstants.invalidNumber;
            } else if (int.parse(value) < 0) {
              return AdvertTextConstants.positiveNumber;
            }
          }
        }
        return null;
      },
    );
  }
}
