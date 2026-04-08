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
              color: _getStatusColor(ticket.status).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: HeroIcon(
                _getStatusIcon(ticket.status),
                size: 32,
                color: _getStatusColor(ticket.status),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.categoryName,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.tertiary,
                    fontWeight: FontWeight.w500,
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
                      dateOnlyFormatter.format(ticket.sessionDate),
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
                      timeOnlyFormatter.format(ticket.sessionDate),
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
          // Status badge
          _buildStatusBadge(context, ticket.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    final color = _getStatusColor(status);
    final text = _getStatusText(status);

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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'confirmed':
        return Colors.green.shade600;
      case 'pending':
      case 'unpaid':
        return Colors.orange.shade600;
      case 'cancelled':
      case 'refunded':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'confirmed':
        return 'Confirmé';
      case 'pending':
      case 'unpaid':
        return 'En attente';
      case 'cancelled':
        return 'Annulé';
      case 'refunded':
        return 'Remboursé';
      default:
        return status;
    }
  }

  HeroIcons _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'confirmed':
        return HeroIcons.checkCircle;
      case 'pending':
      case 'unpaid':
        return HeroIcons.clock;
      case 'cancelled':
        return HeroIcons.xCircle;
      case 'refunded':
        return HeroIcons.arrowUturnLeft;
      default:
        return HeroIcons.ticket;
    }
    }
}
