import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/ui/components/event_countdown.dart';

class EventCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Event event;

  const EventCard({super.key, required this.onTap, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 300;

    final isWebFormat = ref.watch(isWebFormatProvider);
    final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Color.fromARGB(210, 177, 220, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(2, 2),
              spreadRadius: 3,
              color: Color(0x33000000),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              event.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black),
            const SizedBox(height: 20),
            EventCountdown(duration: fifteenAgo),
          ],
        ),
      ),
    );
  }
}
