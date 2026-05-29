import 'package:flutter/material.dart';
import 'package:titan/rplace/class/pixel.dart';

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;
  final double pixelSize;

  MyPainter({required this.pixels, required this.pixelSize});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(
            pixel.x * pixelSize + pixelSize / 2,
            pixel.y * pixelSize + pixelSize / 2,
          ),
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

class FocusPainter extends CustomPainter {
  final double pixelSize;
  final int x;
  final int y;

  FocusPainter({required this.pixelSize, required this.x, required this.y});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(
          x * pixelSize + pixelSize / 2,
          y * pixelSize + pixelSize / 2,
        ),
        width: pixelSize,
        height: pixelSize,
      ),
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
