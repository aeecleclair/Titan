import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SineCurve extends Curve {
  final double livingTime;
  const SineCurve(this.livingTime);

  @override
  double transform(double t) {
    return max(0, sin(2 * pi * (t / livingTime - 0.25)) * 0.5 + 0.5);
  }
}

class Sphere {
  double x;
  double y;
  double t = 0;
  final double radius;
  final double speed;
  final double angle;
  final double livingTime;
  final Curve opacityCurve;
  final Paint paint = Paint()..style = PaintingStyle.fill;
  Sphere(
    this.x,
    this.y,
    this.radius,
    this.speed,
    this.angle,
    this.livingTime,
    this.opacityCurve,
  );

  static Sphere generateNextSphere(double width, double height) {
    final livingTime = 1 + Random().nextDouble() * 2;
    Sphere newSphere = Sphere(
      Random().nextDouble() * 2 * width / 3 + width / 6,
      Random().nextDouble() * 2 * height / 3 + height / 6,
      7 + Random().nextDouble() * 10,
      Random().nextDouble(),
      Random().nextDouble() * 2 * pi,
      livingTime,
      SineCurve(livingTime),
    );
    int green = Random().nextInt(100) + 150;
    newSphere.paint.color = Color.fromARGB(255, 255, green, 0);
    return newSphere;
  }

  void move() {
    x += speed * cos(angle);
    y += speed * sin(angle);
    paint.color = paint.color.withValues(alpha: opacityCurve.transform(t));
    t += 0.01;
  }
}

class AmapBackgroundPainter extends CustomPainter {
  List<Sphere> spheres = [];
  final Animation animation;
  AmapBackgroundPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (Random().nextDouble() < 0.15) {
      spheres.add(Sphere.generateNextSphere(size.width, size.height));
    }
    int i = 0;
    while (i < spheres.length) {
      Sphere sphere = spheres[i];
      if (spheres[i].t > spheres[i].livingTime) {
        spheres.remove(sphere);
      } else {
        i++;
        sphere.move();
        canvas.drawCircle(
          Offset(sphere.x, sphere.y),
          sphere.radius,
          sphere.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
