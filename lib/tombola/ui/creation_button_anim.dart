import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'dart:math';

class CustomButton extends HookConsumerWidget {
  const CustomButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 7000), initialValue: 0)
      ..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: TombolaColorConstants.gradient2.withOpacity(0.3),
                    blurRadius: 2,
                    offset: const Offset(2, 3),
                  ),
                ],
                gradient: RadialGradient(
                    colors: [
                      (animation.value - 0.5).abs() > 0.25
                          ? const Color.fromARGB(255, 255, 249, 220)
                          : const Color.fromARGB(255, 230, 239, 255),
                      (animation.value - 0.5).abs() > 0.25
                          ? const Color.fromARGB(205, 248, 195, 82)
                          : const Color.fromARGB(205, 199, 202, 209),
                      TombolaColorConstants.gradient2,
                    ],
                    transform:
                        GradientRotation(360 * animation.value * pi / 180),
                    center: Alignment.topLeft,
                    radius: 0.7),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                const HeroIcon(HeroIcons.userGroup,
                    color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          );
        });
  }
}
