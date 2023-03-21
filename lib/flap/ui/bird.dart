import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';
import 'package:myecl/flap/providers/bird_image_provider.dart';
import 'package:myecl/flap/tools/image_coloring.dart';

class BirdDisplay extends HookConsumerWidget {
  const BirdDisplay({
    Key? key,
    required this.bird,
    required this.angle,
  }) : super(key: key);

  final Bird bird;
  final double angle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.rotate(
        angle: angle,
        child: SizedBox(
            width: bird.birdSize,
            height: bird.birdSize,
            child: bird.birdImage));
  }
}
