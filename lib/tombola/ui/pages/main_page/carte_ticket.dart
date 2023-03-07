import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TicketWidget extends HookConsumerWidget {
  final Color color;
  const TicketWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Container(
        width: 150,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.2),
              ],
              stops: const [0, 0.8],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      )
    ]);
  }
}
