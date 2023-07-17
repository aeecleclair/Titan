import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/loan/ui/pages/admin_page/edit_delete_item_button.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool showButtons;
  final Function() onEdit;
  final Future Function() onDelete;
  const ItemCard(
      {super.key,
      required this.item,
      required this.showButtons,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    var availableQuantity = item.totalQuantity - item.loanedQuantity;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 140,
        height: (showButtons) ? 160 : 105,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              AutoSizeText(item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 5),
              Text(
                  availableQuantity > 0
                      ? '$availableQuantity ${availableQuantity <= 1 ? LoanTextConstants.available : LoanTextConstants.availableMultiple}'
                      : LoanTextConstants.unavailable,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: availableQuantity > 0
                          ? Colors.grey.shade400
                          : const Color.fromARGB(255, 172, 32, 10))),
              const SizedBox(height: 5),
              AutoSizeText('${item.caution.toStringAsFixed(2)} €',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Spacer(),
              if (showButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const EditDeleteItemButton(
                        child: HeroIcon(HeroIcons.pencil,
                            color: Colors.black),
                      ),
                    ),
                    ShrinkButton(
                      builder: (child) => EditDeleteItemButton(child: child),
                      onTap: onDelete,
                      child:
                          const HeroIcon(HeroIcons.trash, color: Colors.white),
                    ),
                  ],
                ),
              if (showButtons) const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
