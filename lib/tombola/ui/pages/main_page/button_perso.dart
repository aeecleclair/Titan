import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class PresButton extends StatelessWidget {
  const PresButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.blue,
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
