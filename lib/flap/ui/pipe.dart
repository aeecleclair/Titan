import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/providers/pipe_image_provider.dart';

class PipeDisplay extends HookConsumerWidget {
  const PipeDisplay({
    Key? key,
    required this.pipeHeight,
    required this.xPipeAlignment,
    this.isBottomPipe = false,
  }) : super(key: key);

  final double pipeHeight;
  final bool isBottomPipe;
  final double xPipeAlignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipeImage = ref.watch(pipeImageProvider);
    return Container(
        alignment: Alignment(xPipeAlignment, isBottomPipe ? 1 : -1),
        child: SizedBox(
          height: pipeHeight,
          width: 80,
          child: FittedBox(
            alignment:
                isBottomPipe ? Alignment.topCenter : Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            clipBehavior: Clip.hardEdge,
            child: Transform.rotate(
              angle: isBottomPipe ? 0 : pi,
              child: Image.memory(pipeImage),
            ),
          ),
        ));
  }
}
