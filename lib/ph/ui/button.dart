import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final EdgeInsets? margin;

  const MyButton({
    super.key,
    required this.text,
    this.enabled = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 30),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: enabled
              ? [
                  const Color.fromARGB(255, 115, 3, 3),
                  const Color.fromARGB(255, 231, 84, 31),
                ]
              : [Colors.grey.shade200, Colors.grey.shade200],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: enabled
                ? const Color.fromARGB(255, 255, 252, 251)
                : Colors.black,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
