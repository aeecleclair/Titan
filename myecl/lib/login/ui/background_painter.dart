import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:myecl/login/tools/constants.dart';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1);
  }
}

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({
    required Animation<double> animation,
  })  : bluePaint = Paint()
          ..color = ColorConstants.lightBlue
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = ColorConstants.orange
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = ColorConstants.darkBlue
          ..style = PaintingStyle.fill,
        blueAnimation = CurvedAnimation(
            parent: animation,
            curve: const SpringCurve(),
            reverseCurve: Curves.easeInCirc),
        orangeAnimation = CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.7,
                curve: Interval(0, 0.8, curve: SpringCurve())),
            reverseCurve: Curves.linear),
        greyAnimation = CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.8,
                curve: Interval(0, 0.9, curve: SpringCurve())),
            reverseCurve: Curves.easeInCirc),
        liquidAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInBack),
        super(repaint: animation);

  final Animation<double> liquidAnimation;
  final Animation<double> blueAnimation;
  final Animation<double> orangeAnimation;
  final Animation<double> greyAnimation;

  final Paint bluePaint;
  final Paint greyPaint;
  final Paint orangePaint;

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw Exception("Not enough points to draw a path");
    }

    for (int i = 0; i < points.length; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }

  void paintBlue(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      lerpDouble(0, size.width, blueAnimation.value)!.toDouble(),
      lerpDouble(0, size.height, blueAnimation.value)!.toDouble(),
    );
    _addPointsToPath(path, [
      Point(
        0,
        lerpDouble(0, size.height, blueAnimation.value)!.toDouble(),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnimation.value)!
            .toDouble(),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnimation.value)!
            .toDouble(),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value)!
            .toDouble(),
      ),
    ]);
    path.close();

    canvas.drawPath(path, bluePaint);
  }

  void paintGrey(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(size.height / 4, size.height / 2, greyAnimation.value)!.toDouble(),
    );
    _addPointsToPath(path, [
      Point(
        size.width / 4,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value)!.toDouble(),
      ),
      Point(
        size.width * 3 / 5,
        lerpDouble(size.height / 4, size.height / 4 * 3, liquidAnimation.value)!
            .toDouble(),
      ),
      Point(
        size.width * 4 / 5,
        lerpDouble(size.height / 6, size.height / 3, greyAnimation.value)!
            .toDouble(),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 5, size.height / 4, greyAnimation.value)!.toDouble(),
      ),
    ]);
    path.close();

    canvas.drawPath(path, greyPaint);
  }

  void paintOrange(Canvas canvas, Size size) {
    if (orangeAnimation.value > 0) {
      final Path path = Path();

      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, orangeAnimation.value)!.toDouble(),
      );
      _addPointsToPath(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnimation.value)!.toDouble(),
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnimation.value)!.toDouble(),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnimation.value)!.toDouble(),
        ),
        Point(
          size.width / 4 * 3,
          0,
        ),
      ]);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(canvas, size);
    paintGrey(canvas, size);
    paintOrange(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
