import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/mypayment/tools/functions.dart';
import 'package:titan/tools/providers/theme_provider.dart';

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
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final HeroIcons icon;
    final isDarkTheme = ref.watch(themeProvider);
    final canceledColor = const Color(0xffcc4619);

    switch (transaction.type) {
      case HistoryType.given:
        icon = HeroIcons.qrCode;
        break;
      case HistoryType.received:
        icon = HeroIcons.arrowDownRight;
        break;
      case HistoryType.refundCredited:
        icon = HeroIcons.arrowUturnLeft;
        break;
      case HistoryType.refundDebited:
        icon = HeroIcons.arrowUturnRight;
        break;
      case HistoryType.transfer:
        icon = HeroIcons.creditCard;
        break;
    }

    final transactionName = transaction.type != HistoryType.transfer
        ? transaction.otherWalletName
        : "Recharge";

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
              child: HeroIcon(
                icon,
                color: MyPaymentColors.onGradient,
                size: 25,
              ),
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
                              : "${transaction.type == HistoryType.refundCredited || transaction.type == HistoryType.refundDebited ? "Remboursement - " : ""}$transactionName",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
                            color: canceledColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Annulé",
                            style: TextStyle(
                              color: canceledColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (transaction.refund == null) const SizedBox(height: 5),
                  Text(
                    "Le ${DateFormat("EEE dd MMMM yyyy à HH:mm", "fr_FR").format(transaction.creation)}",
                    style: TextStyle(
                      color: MyPaymentColors(isDarkTheme).secondaryGreen,
                      fontSize: 12,
                    ),
                  ),
                  if (transaction.refund != null)
                    Text(
                      "Remboursé le ${DateFormat("EEE dd MMMM yyyy à HH:mm", "fr_FR").format(transaction.refund!.creation)} de ${formatter.format(transaction.refund!.total / 100)} €",
                      style: TextStyle(
                        color: MyPaymentColors(isDarkTheme).secondaryGreen,
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${transaction.type == HistoryType.given || transaction.type == HistoryType.refundDebited ? " -" : " +"} ${formatter.format(transaction.total / 100)} €",
              style: TextStyle(
                color: MyPaymentColors(isDarkTheme).secondaryGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration:
                    (transaction.status == TransactionStatus.confirmed ||
                        transaction.status == TransactionStatus.refunded)
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                decorationColor: MyPaymentColors(
                  isDarkTheme,
                ).secondaryGreen.withValues(alpha: 0.8),
                decorationThickness: 2.85,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
