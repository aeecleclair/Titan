import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/providers/bird_provider.dart';

class BirdDisplay extends HookConsumerWidget {
  const BirdDisplay({
    Key? key,
  }) : super(key: key);

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
                child: bird.birdImage)));
  }
}
