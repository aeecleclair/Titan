import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdSize,
    required this.angle,
  }) : super(key: key);

  final double birdSize;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: birdSize,
        height: birdSize,
        child: Image.asset('images/bird_2.png'),
      ),
    );
  }
}
