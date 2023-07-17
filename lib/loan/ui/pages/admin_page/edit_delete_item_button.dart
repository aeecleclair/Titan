import 'package:flutter/material.dart';

class EditDeleteItemButton extends StatelessWidget {
  final Widget child;
  const EditDeleteItemButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 3))
          ],
        ),
        child: child);
  }
}
