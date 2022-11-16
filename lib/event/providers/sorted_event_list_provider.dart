import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/tools/functions.dart';

final sortedEventListProvider = Provider<Map<String, List<Event>>>((ref) {
  final eventList = ref.watch(eventListProvider);
  final sortedEventList = <String, List<Event>>{};
  final dateTitle = <String, DateTime>{};
  final now = DateTime.now();
  final normalizedNow = normalizedDate(now);
  return eventList.when(
      data: (events) {
        for (final event in events) {
          List<DateTime> normalizedDates = [];
          List<int> deltaDays = [];
          if (event.recurrenceRule.isEmpty) {
            normalizedDates.add(normalizedDate(event.start));
            deltaDays.add(event.end.difference(event.start).inDays);
          } else {
            for (final date
                in getDateInRecurrence(event.recurrenceRule, event.start)) {
              normalizedDates.add(normalizedDate(date));
              deltaDays.add(event.end.difference(event.start).inDays);
            }
          }
          for (int i = 0; i < normalizedDates.length; i++) {
            final DateTime maxDate =
                normalizedNow.compareTo(normalizedDates[i]) <= 0
                    ? normalizedDates[i]
                    : normalizedNow;
            String formatedDelay = formatDelayToToday(maxDate, normalizedNow);
            final e = event.copyWith(
                start: mergeDates(normalizedDates[i], event.start),
                end: mergeDates(
                    normalizedDates[i].add(Duration(days: deltaDays[i])),
                    event.end));
            if (e.end.isAfter(now)) {
              dateTitle[formatedDelay] = normalizedDates[i];
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
        }
        final sortedkeys = sortedEventList.keys.toList(growable: false)
          ..sort((k1, k2) => dateTitle[k1]!.compareTo(dateTitle[k2]!));
        return {for (var k in sortedkeys) k: sortedEventList[k]!};
      },
      loading: () => {},
      error: (error, stack) => {});
});
