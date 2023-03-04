import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String tagname;

  const Tag({super.key, required this.tagname});

  @override
  Widget build(BuildContext context) {

    Color invert(Color color) {
      return Color.fromARGB(
          color.alpha, 255 - color.red, 255 - color.green, 255 - color.blue);
    }

    Color generateColor(String uuid) {
      int hash = 0;
      for (int i = 0; i < uuid.length; i++) {
        hash = 20 * hash + uuid.codeUnitAt(i);
      }
      Color color = Color(hash & 0xFFFFFF).withOpacity(1.0);
      double luminance = color.computeLuminance();
      return luminance < 0.5 ? color : invert(color);
    }
    Color bgColor = generateColor(tagname);
    Color borderColor = bgColor.computeLuminance() > 0.1 ? bgColor : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: 30,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderColor),
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
