import 'package:flutter/material.dart';

class SectionChip extends StatelessWidget {
  final bool selected, isAdmin;
  final String label;
  final Function()? onTap, onDelete;
  const SectionChip({
    super.key,
    required this.label,
    this.isAdmin = false,
    this.selected = false,
    this.onTap,
    this.onDelete,
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
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            if (isAdmin && selected)
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onDelete,
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
