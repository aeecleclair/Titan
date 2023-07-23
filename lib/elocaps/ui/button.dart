import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final String text;

  const MyButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 63, 2, 2),
          Color.fromARGB(255, 189, 65, 20),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 251, 128, 84).withOpacity(0.4),
              offset: const Offset(2, 3),
              blurRadius: 5)
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child:Center(child: Text(
        text,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 254, 164, 131))),
      ),
    );
  }
}
