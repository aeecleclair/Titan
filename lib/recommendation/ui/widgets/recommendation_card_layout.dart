import 'package:flutter/material.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class RecommendationCardLayout extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const RecommendationCardLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: backgroundColor,
      shadowColor: Colors.grey.withValues(alpha: 0.2),
      child: child,
    );
  }
}
