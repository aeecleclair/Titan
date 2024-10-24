import 'package:flutter/material.dart';

class DayDivider extends StatelessWidget {
  const DayDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color(0xff204550),
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text("Aujourd'hui",
                  style: TextStyle(
                      color: Color(0xff204550),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color(0xff204550),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
