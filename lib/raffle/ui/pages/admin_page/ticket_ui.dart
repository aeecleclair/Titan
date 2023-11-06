import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/pack_ticket.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class TicketUI extends HookConsumerWidget {
  final PackTicket packTicket;
  final VoidCallback onEdit;
  final Future Function() onDelete;
  final bool showButton;
  const TicketUI(
      {super.key,
      required this.packTicket,
      required this.onEdit,
      required this.onDelete,
      required this.showButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Container(
        width: 130,
        height: 125,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: RaffleColorConstants.ticketBack.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            color: RaffleColorConstants.ticketBack,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "${packTicket.price} €",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: showButton ? 5 : 10,
                ),
                Text(
                  "${packTicket.packSize} ${RaffleTextConstants.ticket}${packTicket.packSize > 1 ? "s" : ""}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (showButton) const Spacer(),
            if (showButton)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: onEdit,
                  child: CardButton(
                    colors: [Colors.grey.shade100, Colors.grey.shade200],
                    child: const HeroIcon(HeroIcons.pencil,
                        color: RaffleColorConstants.textDark),
                  ),
                ),
                WaitingButton(
                  builder: (child) => CardButton(colors: const [
                    RaffleColorConstants.redGradient1,
                    RaffleColorConstants.redGradient2
                  ], child: child),
                  onTap: onDelete,
                  child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                )
              ])
          ],
        ),
      )
    ]);
  }
}
