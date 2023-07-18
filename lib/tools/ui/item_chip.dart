import 'package:flutter/material.dart';

class ItemChip extends StatelessWidget {
  final bool selected;
  final Function() onTap;
  final Widget child;
  const ItemChip(
      {super.key,
      required this.selected,
      required this.onTap,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
            backgroundColor: selected ? Colors.black : Colors.grey.shade200,
          )),
    );
  }
}
