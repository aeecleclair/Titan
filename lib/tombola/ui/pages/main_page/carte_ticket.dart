import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/tools/constants.dart';

class TicketWidget extends HookConsumerWidget {
  final Ticket ticket;
  final Raffle raffle;
  const TicketWidget({Key? key, required this.ticket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWinningTicket = ticket.winningLot != "";
    return Stack(children: [
      Container(
        width: 150,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isWinningTicket
                    ? const Color.fromARGB(255, 209, 178, 0).withOpacity(0.3)
                    : TombolaColorConstants.ticketback.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            gradient: RadialGradient(
                colors: isWinningTicket
                    ? [
                        const Color.fromARGB(255, 255, 227, 71),
                        const Color.fromARGB(255, 255, 215, 0),
                        const Color.fromARGB(255, 209, 178, 0),
                      ]
                    : [
                        TombolaColorConstants.ticketback,
                        TombolaColorConstants.ticketback
                      ],
                stops: isWinningTicket ? [0.0, 0.1, 1.0] : [0.0, 1.0],
                center: Alignment.topLeft,
                radius: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Image.asset("assets/images/logo.png", height: 40),
                  ),
                ),
                Text(
                  "${ticket.price} €",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "${ticket.nbTicket} tickets",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            AutoSizeText(
              raffle.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    ]);
  }
}
