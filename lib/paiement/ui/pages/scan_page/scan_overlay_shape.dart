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
    this.borderWidth = 5,
    this.borderLength = 50,
    this.borderRadius = 25,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final cutOutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanArea,
      height: scanArea,
    );

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

    final left = cutOutRect.left;
    final top = cutOutRect.top;
    final right = cutOutRect.right;
    final bottom = cutOutRect.bottom;

    final topLeftCorner = Path()
      ..moveTo(left, top + borderLength)
      ..lineTo(left, top + borderRadius)
      ..arcToPoint(
        Offset(left + borderRadius, top),
        radius: Radius.circular(borderRadius),
      )
      ..lineTo(left + borderLength, top);
    canvas.drawPath(topLeftCorner, borderPaint);

    final topRightCorner = Path()
      ..moveTo(right, top + borderLength)
      ..lineTo(right, top + borderRadius)
      ..arcToPoint(
        Offset(right - borderRadius, top),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..lineTo(right - borderLength, top);
    canvas.drawPath(topRightCorner, borderPaint);

    final bottomLeftCorner = Path()
      ..moveTo(left, bottom - borderLength)
      ..lineTo(left, bottom - borderRadius)
      ..arcToPoint(
        Offset(left + borderRadius, bottom),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..lineTo(left + borderLength, bottom);
    canvas.drawPath(bottomLeftCorner, borderPaint);

    final bottomRightCorner = Path()
      ..moveTo(right, bottom - borderLength)
      ..lineTo(right, bottom - borderRadius)
      ..arcToPoint(
        Offset(right - borderRadius, bottom),
        radius: Radius.circular(borderRadius),
      )
      ..lineTo(right - borderLength, bottom);
    canvas.drawPath(bottomRightCorner, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
