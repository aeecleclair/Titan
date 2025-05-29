import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/class/history.dart';

class TransactionCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final HeroIcons icon;

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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: (transaction.type == HistoryType.given ||
                      transaction.type == HistoryType.refundDebited)
                  ? const Color(0xfffe807f)
                  : const Color(0xff017f80),
              child: HeroIcon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
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
                              ? transaction.otherWalletName
                              : "${transaction.type == HistoryType.refundCredited || transaction.type == HistoryType.refundDebited ? "Remboursement - " : ""}${transaction.otherWalletName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff204550),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (transaction.status == TransactionStatus.canceled)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 70, 25)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Annulé",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 204, 70, 25),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Le ${DateFormat("EEE dd MMMM yyyy à HH:mm", "fr_FR").format(transaction.creation)}",
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 12,
                    ),
                  ),
                  if (transaction.refund != null)
                    Text(
                      "Remboursé le  ${DateFormat("EEE dd MMMM yyyy à HH:mm", "fr_FR").format(transaction.refund!.creation)} de ${formatter.format(transaction.refund!.total / 100)} €",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 16, 46, 55),
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${transaction.type == HistoryType.given ? " -" : " +"} ${formatter.format(transaction.total / 100)} €",
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
