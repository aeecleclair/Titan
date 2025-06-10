import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/class/ticket.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class TicketCard extends HookConsumerWidget {
  const TicketCard({super.key, required this.ticket, required this.onClicked});

  final Ticket ticket;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: ticket.scanLeft > 0 ? onClicked : null,
        child: CardLayout(
          color: ticket.scanLeft > 0 ? Colors.white : Colors.grey[400]!,
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
                  "${ticket.scanLeft} scan${ticket.scanLeft > 1 ? 's' : ""} restant${ticket.scanLeft > 1 ? 's' : ""} - Valide jusqu'au ${processDate(ticket.expirationDate)}",
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
