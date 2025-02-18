import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/class/history.dart';

class TransactionCard extends StatelessWidget {
  final History transaction;
  final Function()? onTap;
  const TransactionCard({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final icon = transaction.type == HistoryType.given
        ? HeroIcons.arrowUpRight
        : transaction.type == HistoryType.received
            ? HeroIcons.arrowDownRight
            : HeroIcons.creditCard;
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
              backgroundColor: const Color(0xff017f80),
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
                      AutoSizeText(
                        transaction.otherWalletName,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color(0xff204550),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: transaction.status ==
                                  TransactionStatus.confirmed
                              ? const Color.fromARGB(255, 21, 215, 105)
                                  .withValues(alpha: 0.2)
                              : transaction.status == TransactionStatus.refunded
                                  ? const Color.fromARGB(255, 97, 25, 204)
                                      .withValues(alpha: 0.2)
                                  : const Color.fromARGB(255, 204, 70, 25)
                                      .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          transaction.status == TransactionStatus.confirmed
                              ? "Confirmé"
                              : transaction.status == TransactionStatus.refunded
                                  ? "Remboursé"
                                  : "Annulé",
                          style: TextStyle(
                            color: transaction.status ==
                                    TransactionStatus.confirmed
                                ? const Color.fromARGB(255, 21, 215, 105)
                                : transaction.status ==
                                        TransactionStatus.refunded
                                    ? const Color.fromARGB(255, 97, 25, 204)
                                    : const Color.fromARGB(255, 204, 70, 25),
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
                    "Le ${DateFormat("dd MMM yyyy à HH:mm").format(transaction.creation)}",
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                decoration: transaction.status == TransactionStatus.confirmed
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
