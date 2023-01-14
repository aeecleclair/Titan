import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class DateEntry extends StatelessWidget {
  final String title;
  final DateTime dateBefore;
  final VoidCallback onSelect;
  final TextEditingController controller;

  const DateEntry(
      {Key? key,
      required this.title,
      required this.controller,
      required this.dateBefore,
      required this.onSelect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    selectDate(BuildContext context, TextEditingController dateController,
        DateTime before) async {
      final DateTime now = DateTime.now();
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dateController.text.isNotEmpty
              ? DateTime.parse(processDateBack(dateController.text))
              : before,
          firstDate: before,
          lastDate: DateTime(now.year + 1, now.month, now.day),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorConstants.gradient1,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          });
      dateController.text = processDate(picked ?? now);
      onSelect();
    }

    return GestureDetector(
      onTap: () => selectDate(context, controller, dateBefore),
      child: SizedBox(
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: title,
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return LoanTextConstants.enterDate;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
