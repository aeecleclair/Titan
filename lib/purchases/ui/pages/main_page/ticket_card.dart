import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class TicketCard extends HookConsumerWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.onClicked,
  });

  final Ticket ticket;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          margin: EdgeInsets.zero,
          child: Expanded(
            child: Column(
              children: [
                Text(
                  ticket.productVariant.nameFR,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ticket.productVariant.nameEN,
                  style: const TextStyle(
                    fontSize: 16,
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
