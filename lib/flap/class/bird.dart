import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

class Bird {
  late final SimpleUser user;
  final int score = 0;
  late final Color color;
  final double birdSize = 50;
  final double gravity = -4.9;
  final double velocity = 2.5;
  Widget birdImage = const CircularProgressIndicator();
  double time = 0;
  double birdPosition = 0;
  double initialPosition = 0;

  Bird({
    required this.user,
    required this.color,
  });

  Bird copyWith({
    SimpleUser? user,
    int? score,
    Color? color,
    double? birdSize,
  }) {
    return Bird(
      user: user ?? this.user,
      color: color ?? this.color,
    );
  }

  void setImage(Widget image) {
    birdImage = image;
  }

  void jumpBird() {
    initialPosition = birdPosition;
    time = 0;   
  }

  void update() {
    time += 0.01;
    birdPosition = initialPosition - gravity * time * time + velocity * time;
  }

  Bird.empty() {
    user = SimpleUser.empty();
    color = Colors.black;
  }
}