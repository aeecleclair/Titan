import 'package:flutter/material.dart';

class SectionChip extends StatelessWidget {
  final bool selected;
  final String label;
  final Function() onTap;
  const SectionChip(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});

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
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: selected ? Colors.black : Colors.grey.shade200,
          )),
    );
  }
}
