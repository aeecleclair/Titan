import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/class/purchase.dart';
import 'package:titan/purchases/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/l10n/app_localizations.dart';

class PurchaseCard extends HookConsumerWidget {
  const PurchaseCard({
    super.key,
    required this.purchase,
    required this.onClicked,
  });

  final Purchase purchase;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  purchase.product.nameFR,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              purchase.validated
                  ? Text(
                      "${purchase.quantity} x ${purchase.price / 100} €",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.purchasesNotPaid,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
