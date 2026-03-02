import 'package:flutter/material.dart';

class EventStatusBadge extends StatelessWidget {
  final DateTime eventDate;

  const EventStatusBadge({super.key, required this.eventDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = eventDate.difference(now);

    final String statusText;
    final Color backgroundColor;
    final Color textColor;
    final IconData icon;

    if (difference.isNegative) {
      // Événement passé
      statusText = "Passé";
      backgroundColor = Colors.grey.shade200;
      textColor = Colors.grey.shade700;
      icon = Icons.history;
    } else if (difference.inHours <= 1) {
      // Événement en cours ou imminent (moins de 1h)
      statusText = "En cours";
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
      icon = Icons.play_circle_outline;
    } else {
      // Événement à venir
      statusText = "À venir";
      backgroundColor = Colors.blue.shade100;
      textColor = Colors.blue.shade800;
      icon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
