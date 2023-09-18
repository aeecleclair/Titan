import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DaysEvent extends HookConsumerWidget {
  final DateTime now;
  final String day;
  final List<Event> events;
  const DaysEvent({
    super.key,
    required this.day,
    required this.events,
    required this.now,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventProvider.notifier);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(day,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 149, 149, 149),
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            ...events.map((event) {
              final start = DateTime(event.start.year, event.start.month,
                  event.start.day, event.start.hour, event.start.minute);
              final end = DateTime(event.end.year, event.end.month,
                  event.end.day, event.end.hour, event.end.minute);
              final textColor =
                  start.compareTo(now) <= 0 ? Colors.white : Colors.black;
              return CardLayout(
                margin: const EdgeInsets.all(10),
                height: 135,
                width: double.infinity,
                colors: end.compareTo(now) < 0
                    ? [
                        Colors.grey.shade700,
                        Colors.grey.shade800,
                      ]
                    : start.compareTo(now) <= 0
                        ? [
                            HomeColorConstants.gradient1,
                            HomeColorConstants.gradient2,
                          ]
                        : [
                            Colors.white,
                            Colors.white,
                          ],
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            event.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            eventNotifier.setEvent(event);
                            QR.to(HomeRouter.root + HomeRouter.detail);
                          },
                          child: HeroIcon(
                            HeroIcons.informationCircle,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      formatDates(start, end, event.allDay),
                      style: TextStyle(
                          color: textColor.withOpacity(0.7), fontSize: 13),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event.location,
                          style: TextStyle(color: textColor, fontSize: 15),
                        ),
                        Text(
                          event.organizer,
                          style: TextStyle(color: textColor, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor.withOpacity(0.7), fontSize: 13),
                    ),
                  ],
                ),
              );
            })
          ],
        ));
  }
}
