import 'dart:math';

import 'package:flutter/material.dart';

class PipeDisplay extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              child: Image.asset(
                "images/pipe.png",
              ),
            ),
          ),
        ));
  }
}
