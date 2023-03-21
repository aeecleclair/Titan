import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

class Bird {
  late final SimpleUser user;
  late final int score;
  late final Color color;
  late final double birdSize;
  final double gravity = -4.9;
  final double velocity = 2.5;
  double time = 0;
  double birdPosition = 0;
  double initialPosition = 0;

  Bird({
    required this.user,
    required this.score,
    required this.color,
    required this.birdSize,
  });

  Bird copyWith({
    SimpleUser? user,
    int? score,
    Color? color,
    double? birdSize,
  }) {
    return Bird(
      user: user ?? this.user,
      score: score ?? this.score,
      color: color ?? this.color,
      birdSize: birdSize ?? this.birdSize,
    );
  }

  void jumpBird() {
    initialPosition = birdPosition;
    time = 0;   
  }

  void update() {
    time += 0.01;
    birdPosition = initialPosition - gravity * time * time + velocity * time;
  }
}