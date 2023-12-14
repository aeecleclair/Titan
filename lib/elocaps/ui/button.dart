import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;

  const MyButton({Key? key, required this.text, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 30),
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 115, 3, 3),
          Color.fromARGB(255, 231, 84, 31),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 255, 252, 251),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
