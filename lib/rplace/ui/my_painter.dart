import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'dart:ui';

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;
  final double pixelSize;

  MyPainter({required this.pixels, required this.pixelSize});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(pixel.x * pixelSize + 5, pixel.y * pixelSize + 5),
          width: pixelSize,
          height: pixelSize,
        ),
        Paint()
          ..color = Color(int.parse(pixel.color, radix: 16))
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
