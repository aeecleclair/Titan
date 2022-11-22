import 'package:flutter/material.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool showButtons;
  final Function() onEdit, onDelete;
  const ItemCard(
      {super.key,
      required this.item,
      required this.showButtons,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
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
              Text(item.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 5),
              Text(
                  item.available
                      ? LoanTextConstants.available
                      : LoanTextConstants.unavailable,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400)),
              const SizedBox(height: 5),
              Text('${item.caution.toStringAsFixed(2)} €',
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
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
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
