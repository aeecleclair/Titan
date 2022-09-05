import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/loan/tools/constants.dart';

class DateEntry extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DateEntry({Key? key, required this.title, required this.controller}) : super(key: key);
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
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 85, 85, 85),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectDate(context, controller),
              child: SizedBox(
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 85, 85, 85))),
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
                        return LoanTextConstants.enterDate;
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day));
  dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
}
