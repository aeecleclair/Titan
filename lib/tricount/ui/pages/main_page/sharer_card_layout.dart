import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class SharerCardLayout extends StatelessWidget {
  final Widget child;
  final int depth;
  final double offset;
  const SharerCardLayout(
      {super.key,
      required this.child,
      required this.depth,
      required this.offset});

  @override
  Widget build(BuildContext context) {
    final width = 4.47 * MediaQuery.of(context).size.width / 10;
    final x = depth - offset;
    final angle = (22.5 * x * x + 22.5 * x) * 3.14 / 180;
    final translation = ((40 - width) * x * x + (width + 40) * x);
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle)
          ..scale(1 - 0.15 * x.abs())
          ..translate(translation, 0, 0),
        child: CardLayout(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            color: Colors.white,
            child: child));
  }
}
