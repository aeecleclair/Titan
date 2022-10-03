import 'package:flutter/material.dart';

class UserFieldModifier extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const UserFieldModifier(
      {Key? key,
      required this.label,
      required this.keyboardType,
      required this.controller})
      : super(key: key);

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
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
