import 'package:flutter/material.dart';

class TextEntry extends StatelessWidget {
  final String label, errorMsg;
  final TextEditingController controller;
  const TextEntry(
      {Key? key,
      required this.label,
      required this.errorMsg,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 158, 158, 158),
          ),
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value == null) {
          return errorMsg;
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
