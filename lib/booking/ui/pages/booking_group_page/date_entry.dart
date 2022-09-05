import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/tools/constants.dart';

class DateEntry extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Function(dynamic) onTap;
  const DateEntry(
      {Key? key,
      required this.text,
      required this.controller,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context, controller).then((value) {
                    onTap(value);
                  });
                },
                child: SizedBox(
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return BookingTextConstants.noDateError;
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day));
  if (picked != null) {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(picked),
    );
    dateController.text = DateFormat('yyyy-MM-dd HH:mm')
        .format(DateTimeField.combine(picked, time));
  } else {
    dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(now);
  }
}
