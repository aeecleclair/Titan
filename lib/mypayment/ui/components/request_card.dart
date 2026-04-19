import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/tools/providers/locale_notifier.dart';

class RequestCard extends ConsumerWidget {
  final PaymentRequest request;
  final VoidCallback? onTap;
  const RequestCard({super.key, required this.request, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: "€",
    );
    final localizeWithContext = AppLocalizations.of(context)!;

    final HeroIcons icon;
    final List<Color> colors;
    final String? statusLabel;

    switch (request.status) {
      case RequestStatus.proposed:
        icon = HeroIcons.clock;
        colors = [
          const Color.fromARGB(255, 255, 165, 0),
          const Color.fromARGB(255, 204, 130, 0),
        ];
        statusLabel = localizeWithContext.paiementRequestStatusPending;
      case RequestStatus.accepted:
        icon = HeroIcons.checkCircle;
        colors = [
          const Color.fromARGB(255, 1, 127, 128),
          const Color.fromARGB(255, 0, 102, 103),
        ];
        statusLabel = null;
      case RequestStatus.refused:
        icon = HeroIcons.xCircle;
        colors = [
          const Color.fromARGB(255, 204, 70, 25),
          const Color.fromARGB(255, 163, 56, 20),
        ];
        statusLabel = localizeWithContext.paiementRequestStatusRefused;
      case RequestStatus.expired:
        icon = HeroIcons.clock;
        colors = [
          const Color.fromARGB(255, 128, 128, 128),
          const Color.fromARGB(255, 100, 100, 100),
        ];
        statusLabel = localizeWithContext.paiementRequestStatusExpired;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: colors,
                  center: Alignment.topLeft,
                  radius: 1,
                ),
              ),
              child: HeroIcon(icon, color: Colors.white, size: 25),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          request.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff204550),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (statusLabel != null) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colors[0].withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            statusLabel,
                            style: TextStyle(
                              color: colors[0],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${localizeWithContext.paiementThe} ${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString()).format(request.creation)} ${localizeWithContext.paiementAt} ${DateFormat.Hm(Localizations.localeOf(context).toString()).format(request.creation)}",
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${request.status == RequestStatus.accepted ? "- " : ""}${formatter.format(request.total / 100)}",
              style: TextStyle(
                color: const Color(0xff204550),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration:
                    request.status == RequestStatus.refused ||
                        request.status == RequestStatus.expired
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: const Color(0xff204550).withValues(alpha: 0.8),
                decorationThickness: 2.85,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
