import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';

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

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (controller.isAnimating) return;
        if (details.primaryVelocity! < 0) {
          // Swipe left
          isFront = false;
          controller.reverse();
          ref.invalidate(myWalletProvider);
          ref.invalidate(myHistoryProvider);
        } else if (details.primaryVelocity! > 0) {
          // Swipe right
          isFront = true;
          controller.forward();
        }
      },
      child: AnimatedBuilder(
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
      ),
    );
  }
}
