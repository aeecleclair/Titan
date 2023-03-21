import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

class Bird {
  late final SimpleUser user;
  final int score = 0;
  late final MaterialColor color;
  final double birdSize = 50;
  final double gravity = -4.9;
  final double velocity = 2.5;
  Widget birdImage;
  double time = 0;
  double angle = 0;
  double birdPosition = 0;
  double initialPosition = 0;

  Bird({
    required this.user,
    required this.color,
    this.birdImage = const CircularProgressIndicator(),
  });

  Bird copyWith({
    SimpleUser? user,
    MaterialColor? color,
    Widget? birdImage,
  }) {
    return Bird(
      user: user ?? this.user,
      color: color ?? this.color,
      birdImage: birdImage ?? this.birdImage,
    );
  }

  void jump() {
    initialPosition = birdPosition;
    time = 0;
    angle = - pi / 4;
  }

  void update() {
    time += 0.01;
    birdPosition = initialPosition - gravity * time * time + velocity * time;
    angle += 0.005;
  }

  static Bird empty() {
    return Bird(
      user: SimpleUser.empty(),
      color: Colors.blue,
      birdImage: const CircularProgressIndicator(),
    );
  }
}
