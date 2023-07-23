import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/text_entry.dart';

class TextEditing extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextEditing({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 3),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 158, 158, 158),
                ),
              ),
            ),
            SizedBox(
              child: TextEntry(
                label: label,
                controller: controller,
                color: ColorConstants.gradient1,
              ),
            ),
          ],
        ));
  }
}
