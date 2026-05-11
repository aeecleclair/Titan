import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/ui/components/stat_tile.dart';
import 'package:titan/tools/constants.dart';

class StatsCard extends StatelessWidget {
  final int? ticketsSold;
  final int? ticketsInCheckout;
  final int? quota;

  const StatsCard({
    super.key,
    required this.ticketsSold,
    required this.ticketsInCheckout,
    required this.quota,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorConstants.mainBorder.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HeroIcon(
                HeroIcons.chartBar,
                size: 18,
                color: ColorConstants.tertiary,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.ticketsStatistics,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  label: l10n.ticketsTicketsSold,
                  value: ticketsSold,
                  total: quota,
                  color: ColorConstants.main,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  label: l10n.ticketsTicketsInCheckout,
                  value: ticketsInCheckout,
                  color: ColorConstants.gradient1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
