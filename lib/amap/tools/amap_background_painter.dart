import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sphere {
  double x;
  double y;
  final double radius;
  final double speed;
  final double angle;
  final Paint paint = Paint()..style = PaintingStyle.fill;
  Sphere(this.x, this.y, this.radius, this.speed, this.angle);

  static Sphere generateNextSphere(double width, double height) {
    Sphere newSphere = Sphere(
      Random().nextDouble() * width,
      height + 20,
      7 + Random().nextDouble() * 10,
      1 + Random().nextDouble() * 2,
      -5 * pi / 8 + Random().nextDouble() * pi / 4,
    );
    int green = Random().nextInt(100) + 100;
    int red = 60 + Random().nextInt(green - 99);
    newSphere.paint.color = Color.fromARGB(255, red, green, 0);
    return newSphere;
  }

  void move() {
    x += speed * cos(angle);
    y += speed * sin(angle);
  }
}

class AmapBackgroundPainter extends CustomPainter {
  List<Sphere> spheres = [];
  final Animation animation;
  AmapBackgroundPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (Random().nextDouble() < 0.05) {
      spheres.add(Sphere.generateNextSphere(size.width, size.height));
    }
    int i = 0;
    while (i < spheres.length) {
      Sphere sphere = spheres[i];
      if (sphere.x - sphere.radius > size.width) {
        spheres.remove(sphere);
      } else if (sphere.x + sphere.radius < 0) {
        spheres.remove(sphere);
      } else if (sphere.y + sphere.radius < 0) {
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
