import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';

class CheckItemCard extends StatelessWidget {
  final Item item;
  final Function() onCheck;
  final bool isSelected;
  const CheckItemCard(
      {super.key,
      required this.item,
      required this.onCheck,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCheck,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 140,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Colors.grey.shade400.withOpacity(0.5)
                    : Colors.grey.shade200.withOpacity(0.5),
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
                        color: item.available
                            ? Colors.grey.shade400
                            : const Color.fromARGB(255, 172, 32, 10))),
                const SizedBox(height: 5),
                Text('${item.caution.toStringAsFixed(2)} €',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 5),
                Text(
                    '${LoanTextConstants.duration} : ${item.suggestedLendingDuration ~/ (24 * 60 * 60)} ${LoanTextConstants.days}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
