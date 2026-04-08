import 'package:flutter/material.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class TicketCardLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const TicketCardLayout({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      color: backgroundColor ?? Colors.white,
      shadowColor: Colors.grey.withValues(alpha: 0.25),
      child: child,
    );
  }
}
