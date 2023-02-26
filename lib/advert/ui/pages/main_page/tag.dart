import 'dart:math';
import 'package:flutter/material.dart';


class Tag extends StatelessWidget {
  final String tagname;

  const Tag({super.key, required this.tagname});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Colors.green, Colors.orange, Colors.blue, Colors.red,Colors.green,Colors.pink];
    Random random = Random();
    int cindex = random.nextInt(colors.length);
    Color rdmColor = colors[cindex];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      height: 30,
      decoration: BoxDecoration(
        color: rdmColor,
        borderRadius: BorderRadius.circular(20),
      ),
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
