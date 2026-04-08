import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/shotgun/class/user_ticket.dart';
import 'package:titan/shotgun/ui/components/ticket_card_layout.dart';
import 'package:titan/tools/constants.dart';

class UserTicketCard extends ConsumerWidget {
  final UserTicket ticket;
  const UserTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateOnlyFormatter = DateFormat('dd/MM/yyyy');
    final timeOnlyFormatter = DateFormat('HH:mm');

    return TicketCardLayout(
      child: Row(
        children: [
          // Icône/Event indicator
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: _getStatusColor(ticket.scanned).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: HeroIcon(
                _getStatusIcon(ticket.scanned),
                size: 32,
                color: _getStatusColor(ticket.scanned),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.eventName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.category.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ticket.session.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.onTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                // Date and time
                Row(
                  children: [
                    HeroIcon(
                      HeroIcons.calendar,
                      size: 14,
                      color: ColorConstants.onTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateOnlyFormatter.format(ticket.session.startDatetime),
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    HeroIcon(
                      HeroIcons.clock,
                      size: 14,
                      color: ColorConstants.onTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeOnlyFormatter.format(ticket.session.startDatetime),
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${ticket.price}€',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.gradient1,
                ),
              ),
              const SizedBox(height: 8),
              _buildStatusBadge(context, ticket.scanned),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool scanned) {
    final color = _getStatusColor(scanned);
    final text = _getStatusText(scanned);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(bool scanned) {
    if (scanned) {
      return Colors.grey.shade600;
    }
    return Colors.green.shade600;
  }

  String _getStatusText(bool scanned) {
    if (scanned) {
      return 'Utilisé';
    }
    return 'Valide';
  }

  HeroIcons _getStatusIcon(bool scanned) {
    if (scanned) {
      return HeroIcons.checkCircle;
    }
    return HeroIcons.ticket;
  }
}
