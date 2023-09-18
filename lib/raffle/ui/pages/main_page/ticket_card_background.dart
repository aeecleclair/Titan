import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/tools/winning_ticket_background_painter.dart';
import 'package:myecl/raffle/tools/constants.dart';

class TicketCardBackground extends HookConsumerWidget {
  final bool isWinningTicket;
  final Widget child;
  const TicketCardBackground(
      {Key? key, required this.isWinningTicket, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 0)
      ..repeat();
    return isWinningTicket
        ? Container(
            width: 160,
            height: 200,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(2, 3),
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: AmapBackgroundPainter(animation: animation),
                      child: Container(),
                    ),
                    BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(child: child)),
                  ],
                )))
        : Container(
            width: 160,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: RaffleColorConstants.gradient2.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(2, 3),
                  ),
                ],
                gradient: const RadialGradient(colors: [
                  RaffleColorConstants.gradient1,
                  RaffleColorConstants.gradient2,
                ], center: Alignment.topLeft, radius: 1.5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: child);
  }
}
