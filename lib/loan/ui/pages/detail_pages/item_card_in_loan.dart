import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class ItemCardInLoan extends StatelessWidget {
  final ItemQuantity itemQty;
  const ItemCardInLoan({super.key, required this.itemQty});

  @override
  Widget build(BuildContext context) {
    var item = itemQty.itemSimple;
    return CardLayout(
      id: item.id,
      width: 140,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${itemQty.quantity} ${itemQty.quantity <= 1 ? LoanTextConstants.borrowed : LoanTextConstants.borrowedMultiple}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
