import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/text_entry.dart';

class UserFieldModifier extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const UserFieldModifier(
      {super.key,
      required this.label,
      required this.keyboardType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500),
          ),
        ),
        Expanded(
          child: TextEntry(
            label: label,
            keyboardType: keyboardType,
            controller: controller,
            color: const Color(0xFFfb6d10),
            isInt: keyboardType == TextInputType.number,
          ),
        ),
      ],
    );
  }
}
