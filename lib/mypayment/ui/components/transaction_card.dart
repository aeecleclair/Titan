import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/tools/functions.dart';

class TransactionCard extends ConsumerWidget {
  final History transaction;
  final Function()? onTap;
  final bool storeView;
  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.storeView = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: "€",
    );
    final isDebited = transaction.direction == HistoryDirection.debited;
    final HeroIcons icon;

    switch (transaction.type) {
      case HistoryType.refund:
        icon = isDebited ? HeroIcons.arrowUturnRight : HeroIcons.arrowUturnLeft;
        break;
      case HistoryType.directTransfer:
        icon = HeroIcons.creditCard;
        break;
      case HistoryType.requestTransfer:
        icon = HeroIcons.creditCard;
        break;
      case HistoryType.directTransaction:
        icon = isDebited ? HeroIcons.qrCode : HeroIcons.arrowDownRight;
        break;
      case HistoryType.requestTransaction:
        icon = HeroIcons.ticket;
        break;
    }

    final String transactionName;
    switch (transaction.type) {
      case HistoryType.directTransfer:
      case HistoryType.requestTransfer:
        transactionName = AppLocalizations.of(context)!.paiementTopUp;
        break;
      case HistoryType.requestTransaction:
        transactionName =
            "${AppLocalizations.of(context)!.paiementPaymentRequest} - ${transaction.otherWalletName}";
        break;
      case HistoryType.refund:
      case HistoryType.directTransaction:
        transactionName = transaction.otherWalletName;
        break;
    }

    final colors = getTransactionColors(transaction);

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
                  colors: [colors[0], colors[1]],
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
                          storeView
                              ? transactionName
                              : "${transaction.type == HistoryType.refund ? "${AppLocalizations.of(context)!.paiementRefund} - " : ""}$transactionName",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff204550),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (transaction.status == TransactionStatus.canceled)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              204,
                              70,
                              25,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.paiementRefused,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 204, 70, 25),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (transaction.refund == null) const SizedBox(height: 5),
                  Text(
                    "${AppLocalizations.of(context)!.paiementThe} ${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString()).format(transaction.creation)} ${AppLocalizations.of(context)!.paiementAt} ${DateFormat.Hm(Localizations.localeOf(context).toString()).format(transaction.creation)}",
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 12,
                    ),
                  ),
                  if (transaction.refund != null)
                    Text(
                      "${AppLocalizations.of(context)!.paiementRefundedThe} ${DateFormat.yMMMMEEEEd(locale.toString()).format(transaction.refund!.creation)} +  ${AppLocalizations.of(context)!.paiementAt} ${DateFormat.Hm(locale.toString()).format(transaction.refund!.creation)} ${AppLocalizations.of(context)!.paiementOf} ${formatter.format(transaction.refund!.total / 100)}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 16, 46, 55),
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${isDebited ? " -" : " +"} ${formatter.format(transaction.total / 100)}",
              style: TextStyle(
                color: const Color(0xff204550),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration:
                    (transaction.status == TransactionStatus.confirmed ||
                        transaction.status == TransactionStatus.refunded)
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
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
