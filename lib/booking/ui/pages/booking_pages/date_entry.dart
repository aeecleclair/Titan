import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';

class DateEntry extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final TextEditingController controller;

  const DateEntry(
      {super.key,
      required this.title,
      required this.controller,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return BookingTextConstants.noDateError;
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}