import 'package:flutter/widget_previews.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/ui/components/event_countdown_live.dart';
import 'package:titan/ticketing/ui/components/event_status_badge.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@Preview(name: 'Event Card')
Widget eventCardPreview() {
  final now = DateTime.now();

  return ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F5F7),
        body: Center(
          child: EventCard(
            onTap: () {},
            event: Event(
              id: 'preview-event',
              name: 'Soiree Inge x ECL',
              openDate: now.add(const Duration(days: 2, hours: 3)),
              closeDate: now.add(const Duration(days: 3)),
              quota: 300,
              userQuota: 2,
              // usedQuota: 120,
              disabled: false,
              sessions: const [],
              categories: const [],
            ),
          ),
        ),
      ),
    ),
  );
}

class EventCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Event event;

  const EventCard({super.key, required this.onTap, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = kIsWeb ? 560 : 300;
    const double height = 250;
    const double imageHeight = 130;
    const BorderRadius radius = BorderRadius.all(Radius.circular(20));

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        boxShadow: const [
          // Soft ambient shadow.
          BoxShadow(
            blurRadius: 24,
            offset: Offset(0, 12),
            spreadRadius: -6,
            color: Color(0x1F1E2A78),
          ),
          // Tight contact shadow for definition.
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 1),
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image section
              SizedBox(
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildPlaceholderImage(),
                    // Bottom scrim for depth and smooth transition to content.
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0x33000000)],
                          stops: [0.55, 1.0],
                        ),
                      ),
                    ),
                    // Status badge in top-right
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _Floating(
                        child: EventStatusBadge(eventDate: event.openDate),
                      ),
                    ),
                  ],
                ),
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      AutoSizeText(
                        event.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                          letterSpacing: -0.2,
                          color: Color(0xFF1A1C2E),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat(
                              'dd MMM yyyy • HH:mm',
                            ).format(event.openDate),
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Countdown
                      EventCountdownLive(eventDate: event.openDate),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade400, Colors.indigo.shade600],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.celebration_rounded,
          size: 56,
          color: Colors.white.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}

/// Wraps a child with a subtle drop shadow so badges lift off the image.
class _Floating extends StatelessWidget {
  final Widget child;

  const _Floating({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            color: Color(0x29000000),
          ),
        ],
      ),
      child: child,
    );
  }
}
