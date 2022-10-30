import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/tools/functions.dart';

final daySortedEventListProvider = Provider<Map<DateTime, List<Event>>>((ref) {
  final eventList = ref.watch(eventListProvider);
  final sortedEventList = <DateTime, List<Event>>{};
  return eventList.when(
      data: (events) {
        for (final event in events) {
          List<DateTime> normalizedDates = [];
          if (event.recurrenceRule.isEmpty) {
            normalizedDates.add(normalizedDate(event.start));
          } else {
            normalizedDates =
                getDateInRecurrence(event.recurrenceRule, event.start)
                    .map(
                      (x) => normalizedDate(x),
                    )
                    .toList();
          }
          for (final normalizedDate in normalizedDates) {
            final e = event.copyWith(
                start: mergeDates(normalizedDate, event.start),
                end: mergeDates(normalizedDate, event.end));
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
