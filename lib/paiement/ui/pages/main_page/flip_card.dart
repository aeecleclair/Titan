import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlipCard extends HookConsumerWidget {
  final Widget front;
  final Widget back;
  final AnimationController controller;
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFront = true;
    double anglePlus = 0;

    isFrontImage(double abs) {
      const degrees90 = pi / 2;
      const degrees270 = 3 * pi / 2;

      return abs <= degrees90 || abs >= degrees270;
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double angle = controller.value * -pi;
        if (isFront) angle += anglePlus;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        return Transform(
          alignment: Alignment.center,
          transform: transform,
          child: isFrontImage(angle.abs())
              ? front
              : Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: back,
                ),
        );
      },
    );
  }
}
