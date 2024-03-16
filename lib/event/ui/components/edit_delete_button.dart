import 'package:flutter/material.dart';

class EditDeleteButton extends StatelessWidget {
  final Widget child;
  final Color backGroundColor;
  final Color borderColor;
  const EditDeleteButton({
    super.key,
    required this.child,
    required this.backGroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}
