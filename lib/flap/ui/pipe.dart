import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pipe extends StatelessWidget {
  const Pipe({
    Key? key,
    required this.pipeHeight,
    required this.pipeWidth,
    this.isBottomPipe = false,
    required this.xPipeAlignment,
  }) : super(key: key);

  final double pipeHeight;
  final double pipeWidth;
  final bool isBottomPipe;
  final double xPipeAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(xPipeAlignment, isBottomPipe ? 1 : -1),
      child: Container(
        color: Colors.green,
        height: pipeHeight,
        width: pipeWidth,
      ),
    );
  }
}