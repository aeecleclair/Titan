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
      child: Container(
        color: Colors.green,
        height: pipeHeight,
        width: 80,
      ),
    );
  }
}
