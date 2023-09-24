import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class SharerGroupCard extends HookConsumerWidget {
  final SharerGroup sharerGroup;
  final int depth;
  final double offset;
  const SharerGroupCard({
    super.key,
    required this.sharerGroup,
    required this.depth,
    required this.offset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final x = depth - offset;
    final angle = (7.5 * x * x + 37.5 * x) * 3.14 / 180;
    final translation = (-25 * x * x + 35 * x);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle)
        ..translate(translation, 0, 0)
        ..scale(1.4 - x.abs() * 0.2, 1.0, 1.0),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 12 * x.abs()),
          decoration: BoxDecoration(
              color: Colors.red[(depth + 1) * 100],
              boxShadow: [
                BoxShadow(
                  color: Colors.red[(depth + 1) * 100]!.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..scale(1 / (1.4 - x.abs() * 0.2), 1.0, 1.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    sharerGroup.name,
                    style: const TextStyle(
                        color: Color(0xff09263d),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${sharerGroup.sharers.length} participants",
                    style: const TextStyle(
                        color: Color(0xff09263d),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "${sharerGroup.totalAmount.toStringAsFixed(2)}€",
                    style: const TextStyle(
                        color: Color(0xff1C4668),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              ))),
    );
  }
}
