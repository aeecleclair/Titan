import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'dart:ui';

const nbLigne = 50;
const nbColonne = 50;

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;

  MyPainter({required this.pixels});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(pixel.x, pixel.y),
          width: 10,
          height: 10,
        ),
        Paint()
          ..color = Color(int.parse(pixel.color, radix: 16))
          ..strokeWidth = 10
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
