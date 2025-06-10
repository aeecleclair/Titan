import 'package:flutter/material.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/tools/constants.dart';

class AddAssociationTextEntry extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool canBeEmpty;
  const AddAssociationTextEntry({
    super.key,
    required this.controller,
    required this.title,
    required this.canBeEmpty,
  });

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
            child: Text(
              title,
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
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.gradient1),
                ),
              ),
              validator: canBeEmpty
                  ? null
                  : (value) {
                      if (value == null || value.isEmpty) {
                        return AdminTextConstants.emptyFieldError;
                      }
                      return null;
                    },
            ),
          ),
        ],
      ),
    );
  }
}
