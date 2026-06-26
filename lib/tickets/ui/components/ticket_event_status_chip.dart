import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/adapters/ticket_event.dart';

class TicketEventStatusChip extends StatelessWidget {
  final TicketEventStatus status;

  const TicketEventStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, color) = switch (status) {
      TicketEventStatus.open => (l10n.ticketsStatusOpen, Colors.green.shade600),
      TicketEventStatus.closed => (
        l10n.ticketsStatusClosed,
        Colors.red.shade600,
      ),
      TicketEventStatus.upcoming => (
        l10n.ticketsStatusUpcoming,
        Colors.orange.shade600,
      ),
      TicketEventStatus.disabled => (
        l10n.ticketsStatusDisabled,
        Colors.grey.shade600,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
