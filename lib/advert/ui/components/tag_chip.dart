import 'dart:math';

import 'package:flutter/material.dart';
import 'package:titan/advert/tools/functions.dart';

class TagChip extends StatelessWidget {
  final String tagName;

  const TagChip({super.key, required this.tagName});

  @override
  Widget build(BuildContext context) {
    Color bgColor = generateColor(tagName);
    Color borderColor = bgColor.computeLuminance() > 0.1
        ? bgColor
        : Colors.white;
    Color darkerBgColor = Color.from(
      alpha: bgColor.a,
      red: max(bgColor.r - 0.12, 0), // 0.12 = 30/255
      green: max(bgColor.g - 0.12, 0),
      blue: max(bgColor.b - 0.12, 0),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [bgColor, darkerBgColor],
          stops: const [0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          tagName,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
