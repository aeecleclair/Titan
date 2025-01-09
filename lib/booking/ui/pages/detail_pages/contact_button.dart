import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final Widget child;
  const ContactButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 2,
        ),
        color: Theme.of(context).colorScheme.secondaryFixed,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
