import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  final double scanArea;
  final Color borderColor;
  final double borderWidth;
  final double borderLength;
  final double borderRadius;

  ScannerOverlayPainter({
    required this.scanArea,
    required this.borderColor,
    this.borderWidth = 7,
    this.borderLength = 70,
    this.borderRadius = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Définition du cutout rect (zone de scan)
    final cutOutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanArea,
      height: scanArea,
    );

    // Créer le masque avec une "fenêtre" transparente
    final overlay = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlay, paint);

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Coins (4 lignes par coin)
    final left = cutOutRect.left;
    final top = cutOutRect.top;
    final right = cutOutRect.right;
    final bottom = cutOutRect.bottom;

    // Haut gauche
    canvas.drawLine(
      Offset(left, top + borderLength),
      Offset(left, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left + borderLength, top),
      borderPaint,
    );

    // Haut droite
    canvas.drawLine(
      Offset(right, top + borderLength),
      Offset(right, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, top),
      Offset(right - borderLength, top),
      borderPaint,
    );

    // Bas gauche
    canvas.drawLine(
      Offset(left, bottom - borderLength),
      Offset(left, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, bottom),
      Offset(left + borderLength, bottom),
      borderPaint,
    );

    // Bas droite
    canvas.drawLine(
      Offset(right, bottom - borderLength),
      Offset(right, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, bottom),
      Offset(right - borderLength, bottom),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
