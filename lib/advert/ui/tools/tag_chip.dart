import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myecl/advert/tools/functions.dart';

class TagChip extends StatelessWidget {
  final String tagname;

  const TagChip({super.key, required this.tagname});

  @override
  Widget build(BuildContext context) {
    Color bgColor = generateColor(tagname);
    Color borderColor =
        bgColor.computeLuminance() > 0.1 ? bgColor : Colors.white;
    Color darkerbgColor = Color.fromARGB(
        bgColor.alpha,
        max(bgColor.red - 30, 0),
        max(bgColor.green - 30, 0),
        max(bgColor.blue - 30, 0));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              bgColor,
              darkerbgColor,
            ],
            stops: const [0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: darkerbgColor.withOpacity(0.4),
              offset: const Offset(2, 2),
              spreadRadius: 3,
            )
          ]),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          tagname,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
