import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myecl/flap/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

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

  static Bird empty() {
    final color = Color(0xff000000 + Random().nextInt(0xffffff));
    return Bird(
      user: SimpleUser.empty(),
      color: MaterialColor(color.value, getSwatch(color)),
      birdImage: Image.asset('images/bird_2.png'),
    );
  }
}
