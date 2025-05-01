import 'package:flutter/material.dart';

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
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      controller: nameController,
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      decoration: InputDecoration(
        labelText: name,
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
