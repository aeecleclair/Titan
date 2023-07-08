import 'dart:math';
import 'package:flutter/material.dart';

class Bottle {
  double x;
  double y;
  double h;
  double w;
  final double speed;
  final double angle;
  final Paint paint = Paint()..style = PaintingStyle.fill;
  Bottle(this.x, this.y, this.h, this.w , this.speed, this.angle);

  static Bottle generateNextBottle(double width, double height) {
    Bottle newBottle = Bottle(
        (Random().nextDouble()-0.5) * 200,
        height + 20,
        81,
        25,
        2 + Random().nextDouble() * 2,
        -2 * pi / 3 + Random().nextDouble() * pi / 3);
    int red = 150 + Random().nextInt(100);
    int green = Random().nextInt(red-100) + 50;
    newBottle.paint.color = Color.fromARGB(
      255,
      red,
      green,
      0,
    );
    return newBottle;
  }

  void move() {
    x += speed * cos(angle);
    y += speed * sin(angle);
  }
}

class MyCustomPainter extends CustomPainter {
  List<Bottle> bottles = [];
  final Animation animation;
  MyCustomPainter({required this.animation})
      : super(
          repaint: animation,
        );

  @override
  void paint(Canvas canvas, Size size) {
    //print(bottles.length);
    //print("Size width: ${size.width} et height: ${size.height}");
    if (Random().nextDouble() < 0.15) {
      bottles.add(Bottle.generateNextBottle(size.width, size.height));
    }
    int i = 0;
    while (i < bottles.length) {
      Bottle bottle = bottles[i];
      if (bottle.x - bottle.w > 500) { //500 pour tester mais y a des problèmes de size.width
        bottles.remove(bottle);
      } else if (bottle.x + bottle.w < -500) {
        bottles.remove(bottle);
      } else if (bottle.y + bottle.h < 0) {
        bottles.remove(bottle);
      } else {
        i++;
        bottle.move();
        canvas.save();
        canvas.translate(bottle.x, bottle.y);
        canvas.scale(bottle.w, bottle.h);
        
        Path path = Path();

        path.lineTo(0.25, 0.04);
        path.cubicTo(0.25, 0.04, 0.25, 0.02, 0.26, 0.01);
        path.cubicTo(0.28, 0.01, 0.38, 0, 0.48, 0);
        path.cubicTo(0.58, 0, 0.6, 0, 0.69, 0.01);
        path.cubicTo(0.78, 0.01, 0.72, 0.05, 0.72, 0.05);
        path.cubicTo(0.72, 0.05, 0.72, 0.05, 0.72, 0.05);
        path.cubicTo(0.72, 0.05, 0.71, 0.05, 0.71, 0.05);
        path.cubicTo(0.7, 0.06, 0.7, 0.06, 0.7, 0.06);
        path.cubicTo(0.7, 0.06, 0.74, 0.06, 0.73, 0.07);
        path.cubicTo(0.71, 0.09, 0.77, 0.2, 0.77, 0.2);
        path.cubicTo(0.77, 0.2, 0.81, 0.29, 0.8, 0.3);
        path.cubicTo(0.78, 0.31, 0.95, 0.42, 0.98, 0.42);
        path.cubicTo(1, 0.43, 0.97, 0.79, 0.95, 0.81);
        path.cubicTo(0.94, 0.84, 1, 0.85, 1, 0.85);
        path.cubicTo(1, 0.85, 1, 0.95, 0.92, 0.98);
        path.cubicTo(0.84, 1, 0.48, 1, 0.29, 1);
        path.cubicTo(0.1, 1, 0.07, 0.98, 0.03, 0.95);
        path.cubicTo(-0.02, 0.93, 0, 0.85, 0.02, 0.83);
        path.cubicTo(0.04, 0.82, 0.05, 0.81, 0.05, 0.81);
        path.cubicTo(0.05, 0.81, 0.05, 0.69, 0.03, 0.65);
        path.cubicTo(0.01, 0.6, -0.02, 0.44, 0.03, 0.42);
        path.cubicTo(0.08, 0.4, 0.09, 0.37, 0.16, 0.35);
        path.cubicTo(0.23, 0.33, 0.2, 0.26, 0.2, 0.25);
        path.cubicTo(0.2, 0.23, 0.28, 0.09, 0.28, 0.08);
        path.cubicTo(0.28, 0.08, 0.28, 0.09, 0.27, 0.08);
        path.cubicTo(0.25, 0.06, 0.27, 0.06, 0.27, 0.06);
        path.cubicTo(0.27, 0.06, 0.29, 0.06, 0.29, 0.06);
        path.cubicTo(0.28, 0.05, 0.27, 0.05, 0.26, 0.05);
        path.cubicTo(0.25, 0.04, 0.25, 0.04, 0.25, 0.04);
        path.cubicTo(0.25, 0.04, 0.25, 0.04, 0.25, 0.04);


        canvas.drawPath(path, bottle.paint);
        canvas.restore();
        }
      }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
