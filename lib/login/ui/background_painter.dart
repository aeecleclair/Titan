import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  })  : blueAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: const Interval(
            0.5,
            1,
            curve: Curves.easeIn,
          ),
        ),
        blueAnim2 = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.5,
            curve: Curves.easeOutSine,
          ),
          reverseCurve: const Interval(
            0.5,
            1,
            curve: Curves.easeInSine,
          ),
        ),
        super(repaint: animation);

  final Animation<double> blueAnim;
  final Animation<double> blueAnim2;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();

    var path2 = Path();
    var paint2 = Paint();

    var path3 = Path();
    var paint3 = Paint();

    var w = size.width;
    var h = size.height;

    path.moveTo(w, h / 2);
    path.lineTo(w, 0);
    path.lineTo(0, 0);
    path.lineTo(0, h * 4.2 / 11);
    _addPointsToPath(
      path,
      [
        Point(
          lerpDouble(w * 1.25 / 5, w * 2 / 7, blueAnim.value)!,
          lerpDouble(h * 12 / 25, h * 13 / 25, blueAnim.value)!,
        ),
        Point(
          lerpDouble(w * 5 / 7, w * 4.5 / 7, blueAnim.value)!,
          lerpDouble(h / 13, h / 6.5, blueAnim.value)!,
        ),
        Point(
          w,
          lerpDouble(h / 4, h / 7, blueAnim.value)!,
        ),
      ],
    );

    path2.lineTo(w, 0);
    path2.lineTo(0, 0);
    path2.lineTo(0, h / 12);
    _addPointsToPath(
      path2,
      [
        Point(w / 11, h / 20),
        Point(w * 2 / 9, h / 10),
        Point(w / 3.5, 0),
        Point(w * 5.5 / 9, h / 12),
        Point(w * 2 / 3, 0)
      ],
    );

    path3.moveTo(w, lerpDouble(h * 5 / 6, 0, blueAnim2.value)!);
    path3.lineTo(w, h);
    path3.lineTo(0, h);
    path3.lineTo(0, lerpDouble(h * 5 / 6, 0, blueAnim2.value)!);
    _addPointsToPath(
      path3,
      [
        Point(
          w / 5,
          lerpDouble(h * 7 / 8, 0, blueAnim2.value)!,
        ),
        Point(
          w * 4 / 5,
          lerpDouble(h * 7.5 / 10, 0, blueAnim2.value)!,
        ),
        Point(
          w,
          lerpDouble(h * 4 / 5, 0, blueAnim2.value)!,
        ),
      ],
    );

    var colors = [LoginColorConstants.gradient1, LoginColorConstants.gradient2];

    Rect rectShape = Rect.fromLTWH(0, 0, w, h);
    final Gradient gradient = LinearGradient(
        colors: colors, begin: Alignment.topLeft, end: Alignment.topRight);

    paint = Paint()..color = LoginColorConstants.background;

    paint2 = Paint()..shader = gradient.createShader(rectShape);
    paint3 = Paint()..shader = gradient.createShader(rectShape);

    canvas.drawShadow(
        path, LoginColorConstants.background.withAlpha(125), 10.0, false);
    canvas.drawPath(path3, paint3);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}
