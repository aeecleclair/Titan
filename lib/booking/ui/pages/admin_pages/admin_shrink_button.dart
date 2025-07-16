import 'package:flutter/material.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class AdminShrinkButton extends StatelessWidget {
  final Future<void> Function() onTap;
  final String buttonText;
  const AdminShrinkButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return WaitingButton(
      builder: (child) => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: child,
      ),
      onTap: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
