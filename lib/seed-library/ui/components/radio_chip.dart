import 'package:flutter/material.dart';

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
        margin: const .symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: .circular(30.0),
          color: selected ? Colors.black : Colors.grey.shade200,
        ),
        child: Align(
          alignment: .center,
          child: Padding(
            padding: const .all(10.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: selected ? Colors.white : Colors.black,
                fontWeight: .bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
