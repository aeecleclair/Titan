import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/providers/bird_provider.dart';

class BirdDisplay extends HookConsumerWidget {
  const BirdDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bird = ref.watch(birdProvider);
    return Container(
      alignment: Alignment(-0.5, bird.birdPosition),
      child: Transform.rotate(
        angle: bird.angle,
        child: SizedBox(
          width: bird.birdSize,
          height: bird.birdSize,
          child: bird.birdImage,
        ),
      ),
    );
  }
}
