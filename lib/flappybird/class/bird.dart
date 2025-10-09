import 'dart:math';

import 'package:flutter/material.dart';
import 'package:titan/flappybird/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

class Bird {
  late final SimpleUser user;
  late final MaterialColor color;
  final double birdSize = 50;
  final double gravity = -4.9;
  final double velocity = 2.5;
  final int score;
  final double time;
  final double angle;
  final double birdPosition;
  final double initialPosition;
  final Widget birdImage;

  Bird({
    required this.user,
    required this.color,
    this.birdImage = const CircularProgressIndicator(),
    this.score = 0,
    this.time = 0,
    this.angle = -pi / 6,
    this.birdPosition = 0,
    this.initialPosition = 0,
  });

  Bird copyWith({
    SimpleUser? user,
    MaterialColor? color,
    Widget? birdImage,
    double? birdPosition,
    double? initialPosition,
    double? time,
    double? angle,
    int? score,
  }) {
    return Bird(
      user: user ?? this.user,
      color: color ?? this.color,
      birdImage: birdImage ?? this.birdImage,
      birdPosition: birdPosition ?? this.birdPosition,
      initialPosition: initialPosition ?? this.initialPosition,
      time: time ?? this.time,
      angle: angle ?? this.angle,
      score: score ?? this.score,
    );
  }

  static int getColorValue(Color color) {
    final int red = (color.r * 255).round();
    final int green = (color.g * 255).round();
    final int blue = (color.b * 255).round();
    final int alpha = (color.a * 255).round();
    return alpha << 24 | red << 16 | green << 8 | blue;
  }

  static Bird empty() {
    final color = Color(0xff000000 + Random().nextInt(0xffffff));
    return Bird(
      user: SimpleUser.empty(),
      color: MaterialColor(getColorValue(color), getSwatch(color)),
      birdImage: Image.asset('images/bird.png'),
    );
  }
}
