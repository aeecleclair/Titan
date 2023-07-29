import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;

  const MyButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 63, 2, 2),
          Color.fromARGB(255, 231, 84, 31),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 254, 164, 131),
          ),
          maxLines: 1, 
        ),
      ),
    );
  }
}
