import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/tools/functions.dart';

final sortedEventListProvider = Provider<Map<String, List<Event>>>((ref) {
  final eventList = ref.watch(eventListProvider);
  final sortedEventList = <String, List<Event>>{};
  final dateTitle = <String, DateTime>{};
  final now = normalizedDate(DateTime.now());
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
            String formatedDelay = formatDelayToToday(normalizedDate, now);
            final e = event.copyWith(
                start: mergeDates(normalizedDate, event.start),
                end: mergeDates(normalizedDate, event.end));
            dateTitle[formatedDelay] = normalizedDate;
            if (sortedEventList.containsKey(formatedDelay)) {
              final index = sortedEventList[formatedDelay]!
                  .indexWhere((element) => element.start.isAfter(e.start));
              if (index == -1) {
                sortedEventList[formatedDelay]!.add(e);
              } else {
                sortedEventList[formatedDelay]!.insert(index, e);
              }
            } else {
              sortedEventList[formatedDelay] = [e];
            }
          }
        }
        final sortedkeys = sortedEventList.keys.toList(growable: false)
          ..sort((k1, k2) => dateTitle[k1]!.compareTo(dateTitle[k2]!));
        return {for (var k in sortedkeys) k: sortedEventList[k]!};
      },
      loading: () => {},
      error: (error, stack) => {});
});
