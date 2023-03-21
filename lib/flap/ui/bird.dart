import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';
import 'package:myecl/flap/providers/bird_image_provider.dart';

class BirdDisplay extends HookConsumerWidget {
  const BirdDisplay({
    Key? key,
    required this.bird,
  }) : super(key: key);

  final Bird bird;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.rotate(
        angle: bird.angle,
        child: SizedBox(
            width: bird.birdSize,
            height: bird.birdSize,
            child: bird.birdImage));
  }
}
