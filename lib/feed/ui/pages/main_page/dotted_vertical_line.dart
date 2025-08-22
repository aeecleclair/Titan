import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

/// A widget that displays a vertical line of evenly spaced dots.
/// The number of dots is calculated based on the height of the widget.
class DottedVerticalLine extends StatelessWidget {
  /// The spacing between each dot in logical pixels.
  final double dotSpacing;

  /// The diameter of each dot in logical pixels.
  final double dotSize;

  /// The color of the dots. Defaults to [ColorConstants.secondary].
  final Color? dotColor;

  const DottedVerticalLine({
    super.key,
    this.dotSpacing = 6.0,
    this.dotSize = 2.0,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        // Calculate how many dots we can fit in the height
        // We add 1 to dotSpacing to account for the space between dots plus the dot itself
        final dotsCount = (height / (dotSize + dotSpacing)).floor();

        return CustomPaint(
          size: Size(dotSize, height),
          painter: _DottedLinePainter(
            dotSpacing: dotSpacing,
            dotSize: dotSize,
            dotsCount: dotsCount,
            dotColor: dotColor ?? ColorConstants.secondary,
          ),
        );
      },
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final double dotSpacing;
  final double dotSize;
  final int dotsCount;
  final Color dotColor;

  _DottedLinePainter({
    required this.dotSpacing,
    required this.dotSize,
    required this.dotsCount,
    required this.dotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = dotSize;

    // Start position
    double startY = 0;

    // Draw dots
    for (int i = 0; i < dotsCount; i++) {
      // Calculate y position for this dot
      double yPosition = startY + (i * (dotSize + dotSpacing));

      // Draw the dot
      canvas.drawCircle(Offset(size.width / 2, yPosition), dotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
