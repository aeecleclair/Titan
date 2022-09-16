import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/home/tools/functions.dart';

class EventUI extends HookConsumerWidget {
  final Event r;
  final double l;
  final int n;
  final bool neverStart, neverEnd;
  const EventUI(
      {Key? key,
      required this.r,
      required this.l,
      this.n = 1,
      this.neverEnd = false,
      this.neverStart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventPageNotifier = ref.watch(eventPageProvider.notifier);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final appPageNotifier = ref.watch(pageProvider.notifier);
    return GestureDetector(
      onTap: () {
        eventNotifier.setEvent(r);
        eventPageNotifier.setEventPage(EventPage.eventDetailfromCalendar);
        appPageNotifier.setPage(ModuleType.event);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 2, bottom: 2),
        height: l * 90.0 - 4,
        decoration: BoxDecoration(
          color: uuidToColor(r.id),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25 - 10 * (n - 1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                if (neverStart)
                  Column(children: [
                    SizedBox(
                      width: 140 / n,
                      child: const HeroIcon(
                        HeroIcons.chevronDoubleUp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ]),
                SizedBox(
                  width: 140 / n,
                  child: Text(r.name + " - " + r.location,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 3,
                ),
                if (l > 1)
                  Text(doubleToTime(r.end.difference(r.start).inMinutes / 60),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.5))),
                const Spacer(),
                if (neverEnd)
                  Column(children: [
                    SizedBox(
                      width: 140 / n,
                      child: const HeroIcon(
                        HeroIcons.chevronDoubleDown,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
