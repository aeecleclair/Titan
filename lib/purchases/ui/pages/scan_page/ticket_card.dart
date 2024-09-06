import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/generated_ticket.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class TicketCard extends HookConsumerWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.onClicked,
  });

  final GeneratedTicket ticket;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${ticket.maxUse} scan${ticket.maxUse > 1 ? 's' : ""} maximun - Valide jusqu'au ${processDate(ticket.expiration)}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
