import 'package:flutter/material.dart';

// This component seems to be used nowhere...

class RadioChip extends StatelessWidget {
  final bool selected;
  final String label;
  final Function() onTap;
  const RadioChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Chip(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color: selected
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: selected
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.secondaryFixed,
        ),
      ),
    );
  }
}
