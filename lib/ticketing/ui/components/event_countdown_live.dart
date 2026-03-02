import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventCountdownLive extends HookConsumerWidget {
  final DateTime eventDate;

  const EventCountdownLive({super.key, required this.eventDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = useState(DateTime.now());

    // Mise à jour toutes les secondes pour le countdown
    useEffect(() {
      final timer = Stream.periodic(const Duration(seconds: 1), (_) {
        now.value = DateTime.now();
      }).listen((_) {});

      return timer.cancel;
    }, []);

    final difference = eventDate.difference(now.value);

    if (difference.isNegative) {
      // Événement passé
      final daysSince = difference.abs().inDays;
      if (daysSince == 0) {
        return _buildSimpleBadge(
          "En ce moment",
          Colors.green.shade700,
          Icons.event_available,
        );
      } else if (daysSince == 1) {
        return _buildSimpleBadge(
          "Il y a 1 jour",
          Colors.grey.shade600,
          Icons.event_busy,
        );
      } else {
        return _buildSimpleBadge(
          "Il y a $daysSince jours",
          Colors.grey.shade600,
          Icons.event_busy,
        );
      }
    } else {
      // Événement à venir
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      // Si l'événement est dans moins de 7 jours, afficher le countdown détaillé
      if (days < 7) {
        return _buildDetailedCountdown(days, hours, minutes, seconds);
      } else {
        // Pour les événements lointains, afficher un badge simple
        final weeks = (days / 7).floor();
        if (weeks == 1) {
          return _buildSimpleBadge(
            "Dans 1 semaine",
            Colors.blue.shade600,
            Icons.calendar_today,
          );
        } else if (weeks < 4) {
          return _buildSimpleBadge(
            "Dans $weeks semaines",
            Colors.blue.shade600,
            Icons.calendar_today,
          );
        } else {
          final months = (days / 30).floor();
          return _buildSimpleBadge(
            "Dans $months mois",
            Colors.blue.shade600,
            Icons.calendar_today,
          );
        }
      }
    }
  }

  Widget _buildSimpleBadge(String text, Color color, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedCountdown(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 14, color: Colors.blue.shade700),
          const SizedBox(width: 6),
          if (days > 0) ...[
            _buildTimeUnit(days.toString(), 'j'),
            const SizedBox(width: 4),
          ],
          _buildTimeUnit(hours.toString().padLeft(2, '0'), 'h'),
          const SizedBox(width: 4),
          _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'm'),
          const SizedBox(width: 4),
          _buildTimeUnit(seconds.toString().padLeft(2, '0'), 's'),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String value, String unit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade700,
          ),
        ),
      ],
    );
  }
}
