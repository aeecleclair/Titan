import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final String categoryName;
  final double categoryPrice;

  const CategoryCard({
    super.key,
    required this.onTap,
    required this.categoryName,
    required this.categoryPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(210, 200, 230, 201),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(2, 2),
              spreadRadius: 3,
              color: Color(0x33000000),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text(
              "${categoryPrice.toStringAsFixed(2)} €",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
