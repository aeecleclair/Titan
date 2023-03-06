import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TicketWidget extends HookConsumerWidget {
  const TicketWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Stack(children: [
      Container(
        width: 150,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: this.color,
                blurRadius: 8,
                blurStyle:BlurStyle.outer,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                this.color.withOpacity(0.1),
                this.color.withOpacity(0.2),
              ],
              stops: const [0, 0.8],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      )
    ]);
  }
}
