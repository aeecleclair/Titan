import 'package:flutter/material.dart';

class MonthSectionSummary extends StatelessWidget {
  final String title;
  final String amount;
  final Color color, darkColor, shadowColor;
  const MonthSectionSummary({
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
      height: 60,
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

          colors: [darkColor, color, darkColor],
        ),
        boxShadow: [
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
    );
  }
}
