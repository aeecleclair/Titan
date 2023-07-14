import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final Widget child;
  const AdminButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: child,
    );
  }
}
