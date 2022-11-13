import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/loan/tools/constants.dart';

class DateEntry extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DateEntry({Key? key, required this.title, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
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

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 172, 32, 10),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
  if (picked != null) {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(picked),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 172, 32, 10),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!),
        );
      },
    );
    dateController.text = DateFormat('yyyy-MM-dd HH:mm')
        .format(DateTimeField.combine(picked, time));
  } else {
    dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(now);
  }
}
