import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/providers/pipe_list_provider.dart';
import 'package:titan/flappybird/ui/pages/game_page/pipe.dart';

class PipeHandler extends HookConsumerWidget {
  final double constraints;
  const PipeHandler({super.key, required this.constraints});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipes = ref.watch(pipeListProvider);
    return Stack(
      children: pipes
          .map(
            (e) => Stack(
              children: [
                PipeDisplay(
                  pipeHeight: e.height,
                  isBottomPipe: true,
                  xPipeAlignment: e.position,
                ),
                PipeDisplay(
                  pipeHeight: max(constraints - e.height - 200, 0),
                  xPipeAlignment: e.position,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
