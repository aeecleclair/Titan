import 'package:auto_size_text/auto_size_text.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              ticket.prize == null ? "Lot" : ticket.prize!.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                AutoSizeText(
                  ticket.user.nickname ?? ticket.user.firstname,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                AutoSizeText(
                  ticket.user.nickname != null
                      ? "${ticket.user.firstname} ${ticket.user.name}"
                      : ticket.user.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  minFontSize: 10,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
