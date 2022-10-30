import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/tools/functions.dart';

final daySortedEventListProvider = Provider<Map<DateTime, List<Event>>>((ref) {
  final eventList = ref.watch(eventListProvider);
  final sortedEventList = <DateTime, List<Event>>{};
  DateTime now = DateTime.now();
  now = DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);
  return eventList.when(
      data: (events) {
        for (final event in events) {
          List<DateTime> normalizedDates = [];
          if (event.recurrenceRule.isEmpty) {
            normalizedDates.add(DateTime(event.start.year, event.start.month,
                event.start.day, 0, 0, 0, 0, 0));
          } else {
            normalizedDates =
                getDateInRecurrence(event.recurrenceRule, event.start)
                    .map(
                      (x) => DateTime(x.year, x.month, x.day, 0, 0, 0, 0, 0),
                    )
                    .toList();
          }
          for (final normalizedDate in normalizedDates) {
            final e = event.copyWith(
                start: DateTime(
                    normalizedDate.year,
                    normalizedDate.month,
                    normalizedDate.day,
                    event.start.hour,
                    event.start.minute,
                    event.start.second,
                    event.start.millisecond),
                end: DateTime(
                    normalizedDate.year,
                    normalizedDate.month,
                    normalizedDate.day,
                    event.end.hour,
                    event.end.minute,
                    event.end.second,
                    event.end.millisecond));
            if (sortedEventList.containsKey(normalizedDate)) {
              final index = sortedEventList[normalizedDate]!
                  .indexWhere((element) => element.start.isAfter(e.start));
              if (index == -1) {
                sortedEventList[normalizedDate]!.add(e);
              } else {
                sortedEventList[normalizedDate]!.insert(index, e);
              }
            } else {
              sortedEventList[normalizedDate] = [e];
            }
          }
        }
        final sortedkeys = sortedEventList.keys.toList(growable: false)
          ..sort((k1, k2) => k1.compareTo(k2));
        return {for (var k in sortedkeys) k: sortedEventList[k]!};
      },
      loading: () => {},
      error: (error, stack) => {});
});
