import 'package:flutter/material.dart';

class ItemChip extends StatelessWidget {
  final bool selected;
  final Function()? onTap;
  final Widget child;
  final bool vertical;
  const ItemChip({
    super.key,
    this.selected = false,
    this.onTap,
    this.vertical = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: vertical ? double.infinity : null,
        margin: EdgeInsets.symmetric(
          horizontal: vertical ? 0.0 : 10.0,
          vertical: vertical ? 5.0 : 0.0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: selected ? Colors.black : Colors.grey.shade200,
        ),
        child: Center(child: child),
      ),
    );
  }
}
