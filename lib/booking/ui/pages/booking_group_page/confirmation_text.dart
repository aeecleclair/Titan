import 'package:flutter/material.dart';

class ConfirmationText extends StatelessWidget {
  final String title, value;
  const ConfirmationText({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title : ",
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}
