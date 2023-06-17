import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/tools/constants.dart';

class ItemCardInLoan extends StatelessWidget {
  final ItemQuantity itemQty;
  const ItemCardInLoan({super.key, required this.itemQty});

  @override
  Widget build(BuildContext context) {
    var item = itemQty.itemSimple;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 140,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 10),
              Text(
                '${itemQty.quantity} ${itemQty.quantity <= 1
                        ? LoanTextConstants.borrowed
                        : LoanTextConstants.borrowedMultiple}',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
