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

_selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    showDatePicker(
    locale: const Locale("fr", "FR"),
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 10, 153, 172),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        }).then((picked) {
      if (picked != null) {
        showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 10, 153, 172),
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            }).then((value) {
          dateController.text = DateFormat('dd/MM/yyyy HH:mm')
              .format(DateTimeField.combine(picked, value));
        });
      } else {
        dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(now);
      }
    });
  }
