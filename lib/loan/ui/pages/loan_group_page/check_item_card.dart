import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class CheckItemCard extends StatelessWidget {
  final Item item;
  final bool isSelected;
  const CheckItemCard({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      id: item.id,
      width: 140,
      height: 130,
      borderColor: isSelected
          ? Theme.of(context).colorScheme.onPrimary
          : Colors.transparent,
      shadowColor: (isSelected
              ? Theme.of(context).shadowColor
              : Theme.of(context).colorScheme.secondaryFixed)
          .withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          AutoSizeText(
            item.name,
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item.loanedQuantity < item.totalQuantity
                ? '${item.totalQuantity - item.loanedQuantity} ${LoanTextConstants.available}'
                : LoanTextConstants.unavailable,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: item.loanedQuantity < item.totalQuantity
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onError,
            ),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            '${item.caution.toStringAsFixed(2)} €',
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            '${LoanTextConstants.duration} : ${item.suggestedLendingDuration.toInt()} ${LoanTextConstants.days}',
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
