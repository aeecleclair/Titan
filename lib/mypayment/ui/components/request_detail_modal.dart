import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/mypayment/ui/components/paiment_delegate/product_card.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class RequestDetailModal extends StatelessWidget {
  final PaymentRequest request;
  const RequestDetailModal({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final dateFormatter = DateFormat.yMMMMEEEEd().add_Hm();

    final String statusLabel;
    final Color statusColor;
    final HeroIcons statusIcon;

    switch (request.status) {
      case RequestStatus.accepted:
        statusLabel = localizeWithContext.paiementRequestStatusAccepted;
        statusColor = const Color.fromARGB(255, 1, 127, 128);
        statusIcon = HeroIcons.checkCircle;
      case RequestStatus.refused:
        statusLabel = localizeWithContext.paiementRequestStatusRefused;
        statusColor = const Color.fromARGB(255, 204, 70, 25);
        statusIcon = HeroIcons.xCircle;
      case RequestStatus.expired:
        statusLabel = localizeWithContext.paiementRequestStatusExpired;
        statusColor = const Color.fromARGB(255, 128, 128, 128);
        statusIcon = HeroIcons.clock;
      case RequestStatus.proposed:
        statusLabel = localizeWithContext.paiementRequestStatusPending;
        statusColor = const Color.fromARGB(255, 255, 165, 0);
        statusIcon = HeroIcons.clock;
    }

    return BottomModalTemplate(
      title: localizeWithContext.paiementRequestDetails,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductCard(
              title: request.name,
              description: request.storeNote ?? '',
              priceInCents: request.total,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  HeroIcon(statusIcon, color: statusColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateFormatter.format(request.creation),
                          style: TextStyle(
                            color: statusColor.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Button.secondary(
              text: localizeWithContext.paiementClose,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
