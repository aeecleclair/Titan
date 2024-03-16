import 'package:flutter/material.dart';

class ItemChip extends StatelessWidget {
  final bool selected;
  final Function()? onTap;
  final Widget child;
  const ItemChip({
    super.key,
    this.selected = false,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: selected ? Colors.black : Colors.grey.shade200,
        ),
        child: child,
      ),
    );
  }
}
