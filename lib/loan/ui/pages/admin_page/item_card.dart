import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool showButtons;
  final Function() onEdit;
  final Future Function() onDelete;
  const ItemCard({
    super.key,
    required this.item,
    required this.showButtons,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    var availableQuantity = item.totalQuantity - item.loanedQuantity;
    return CardLayout(
      id: item.id,
      width: 140,
      height: (showButtons) ? 150 : 95,
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          AutoSizeText(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            availableQuantity > 0
                ? '$availableQuantity ${availableQuantity <= 1 ? LoanTextConstants.available : LoanTextConstants.availableMultiple}'
                : LoanTextConstants.unavailable,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: availableQuantity > 0
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            '${item.caution.toStringAsFixed(2)} €',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: CardButton(
                    color: Theme.of(context).colorScheme.secondaryFixed,
                    child: const HeroIcon(HeroIcons.pencil),
                  ),
                ),
                WaitingButton(
                  builder: (child) => CardButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: child,
                  ),
                  onTap: onDelete,
                  child: HeroIcon(
                    HeroIcons.trash,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          if (showButtons) const SizedBox(height: 10),
        ],
      ),
    );
  }
}
