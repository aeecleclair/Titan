import 'package:flutter/material.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';

class VoterChip extends StatelessWidget {
  final bool selected;
  final String label;
  final Function() onTap;
  const VoterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ItemChip(
        onTap: onTap,
        selected: selected,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
