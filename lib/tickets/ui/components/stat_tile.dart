import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class StatTile extends StatelessWidget {
  final String label;
  final int? value;
  final int? total;
  final Color color;

  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    final hasTotal = total != null && total! > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: ColorConstants.tertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${value ?? 0}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (hasTotal)
                  TextSpan(
                    text: ' / $total',
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorConstants.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
