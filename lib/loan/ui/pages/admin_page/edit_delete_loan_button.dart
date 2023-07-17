import 'package:flutter/material.dart';

class EditDeleteLoanButton extends StatelessWidget {
  final Widget child;
  final Color color;
  const EditDeleteLoanButton(
      {super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 3))
          ],
        ),
        child: child);
  }
}
