import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class AdminEntry extends StatelessWidget {
  final String name;
  final TextEditingController nameController;
  const AdminEntry({
    super.key,
    required this.name,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: ColorConstants.background2),
      controller: nameController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: name,
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
    );
  }
}
