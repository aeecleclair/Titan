import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/ui/pages/main_page/ticket_card_background.dart';

class TicketWidget extends HookConsumerWidget {
  final Ticket ticket;
  final Raffle raffle;
  const TicketWidget({Key? key, required this.ticket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWinningTicket = ticket.winningLot != "";
    return Stack(children: [
      TicketCardBackground(
          isWinningTicket: isWinningTicket,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
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
                        child:
                            Image.asset("assets/images/logo.png", height: 40),
                      ),
                    ),
                    Text(
                      "${ticket.unitPrice} €",
                      style: TextStyle(
                          color: isWinningTicket ? Colors.black : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "${ticket.nbTicket} tickets",
                  style: TextStyle(
                      color: isWinningTicket
                          ? Colors.black.withOpacity(0.8)
                          : Colors.white.withOpacity(0.8),
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
                  style: TextStyle(
                      color: isWinningTicket ? Colors.black : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    ]);
  }
}
