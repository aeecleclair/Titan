import 'package:flutter/material.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';

// This component seems to be used nowhere...
// That's the 3rd on Phonebook alone!

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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          SizedBox(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
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
