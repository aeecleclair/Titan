import 'package:flutter/material.dart';
import 'package:titan/tools/functions.dart';

class DayDivider extends StatelessWidget {
  final String date;
  const DayDivider({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 5),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: Color(0xff204550), thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                capitalize(date),
                style: const TextStyle(
                  color: Color(0xff204550),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: Color(0xff204550), thickness: 1),
          ),
        ],
      ),
    );
  }
}
