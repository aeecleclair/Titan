import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'dart:ui';

const nb_ligne = 50;
const nb_colonne = 50;

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;

  MyPainter({required this.pixels});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawPoints(
        PointMode.points,
        [Offset(pixel.x, pixel.y)],
        Paint()
          ..color = Color(int.parse(pixel.color, radix: 16))
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
