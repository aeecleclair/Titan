import 'package:flutter/material.dart';
import 'package:titan/paiement/ui/pages/stats_page/description_shape.dart';

class SumUpCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color, darkColor, shadowColor;
  const SumUpCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.darkColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      height: 136,
      width: 90,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        margin: const EdgeInsets.only(bottom: 60),
        decoration: ShapeDecoration(
          shape: const MessageBorder(),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [darkColor, color, darkColor],
          ),
          shadows: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            // const SizedBox(height: 3),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
