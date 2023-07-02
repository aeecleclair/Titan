import 'package:flutter/material.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';

class TextEditing extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextEditing({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
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
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorConstants.gradient1))),
                validator: (value) {
                  if (value == null) {
                    return AdminTextConstants.emptyFieldError;
                  } else if (value.isEmpty) {
                    return AdminTextConstants.emptyFieldError;
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ));
  }
}
