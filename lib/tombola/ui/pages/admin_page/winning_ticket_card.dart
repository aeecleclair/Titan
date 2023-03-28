import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/tools/constants.dart';

class WinningTicketUI extends HookConsumerWidget {
  final Ticket ticket;
  final VoidCallback onEdit;
  final Future Function() onDelete;
  const WinningTicketUI({
    Key? key,
    required this.ticket,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

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
                color: TombolaColorConstants.ticketback.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            color: TombolaColorConstants.ticketback,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${ticket.lot!.name} €",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ticket.user.nickname ?? ticket.user.firstname,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ticket.user.nickname != null
                  ? "${ticket.user.firstname} ${ticket.user.name}"
                  : ticket.user.name,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    ]);
  }
}
