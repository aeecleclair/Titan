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
                color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        Expanded(
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.tertiary),
            cursorColor: const Color(0xFFfb6d10),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFfb6d10)))),
          ),
        ),
      ],
    );
  }
}
