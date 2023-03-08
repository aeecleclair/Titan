import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tombola/class/type_ticket.dart';

class TicketUI extends HookConsumerWidget {
  final TypeTicket typeTicket;
  const TicketUI({Key? key, required this.typeTicket}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = generateColor(typeTicket.raffleId);
    return Stack(children: [
      Container(
        width: 130,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          children: [
            Text(
              "${typeTicket.price} €",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "${typeTicket.nbTicket} tickets",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )
    ]);
  }
}
