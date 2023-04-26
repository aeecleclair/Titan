import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'dart:math';

class CreationButton extends HookConsumerWidget {
  const CreationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 10000), initialValue: 0)
      ..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: TombolaColorConstants.gradient2.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
          gradient: RadialGradient(colors: [
            Color.fromARGB(255, 250, 250, 210),
            TombolaColorConstants.gradient2,
          ], transform: GradientRotation(360* animation.value * pi / 180),
          center: Alignment.bottomRight, radius: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: const [
          HeroIcon(HeroIcons.userGroup, color: Colors.white, size: 20),
          SizedBox(width: 10),
          Text("Modifier",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );});
  }
}
