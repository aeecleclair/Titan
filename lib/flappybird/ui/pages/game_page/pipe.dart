import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/providers/pipe_image_provider.dart';

class PipeDisplay extends HookConsumerWidget {
  const PipeDisplay({
    super.key,
    required this.pipeHeight,
    required this.xPipeAlignment,
    this.isBottomPipe = false,
  });

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
          alignment: isBottomPipe
              ? Alignment.topCenter
              : Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          clipBehavior: Clip.hardEdge,
          child: Transform.flip(
            flipY: !isBottomPipe,
            child: pipeImage.isNotEmpty ? Image.memory(pipeImage) : Container(),
          ),
        ),
      ),
    );
  }
}
