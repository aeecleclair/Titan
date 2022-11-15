import 'package:flutter/material.dart';

class SectionChip extends StatelessWidget {
  final bool selected, isAdmin;
  final String label;
  final Function() onTap, onDelete;
  const SectionChip(
      {super.key,
      required this.label,
      required this.isAdmin,
      required this.selected,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  if (isAdmin && selected)
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: onDelete,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            ),
            backgroundColor: selected ? Colors.black : Colors.grey.shade200,
          )),
    );
  }
}
