import 'package:flutter/material.dart';

class ItemChip extends StatelessWidget {
  final bool selected;
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget child;
  const ItemChip({
    super.key,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
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
