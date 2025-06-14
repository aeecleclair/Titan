import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/confirmed_event_list_provider.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/tools/functions.dart';

final sortedEventListProvider = Provider<Map<String, List<Event>>>((ref) {
  final eventList = ref.watch(confirmedEventListProvider);
  final sortedEventList = <String, List<Event>>{};
  final dateTitle = <String, DateTime>{};
  final now = DateTime.now();
  final normalizedNow = normalizedDate(now);
  return eventList.maybeWhen(
    data: (events) {
      for (final event in events) {
        List<DateTime> normalizedDates = [];
        List<int> deltaDays = [];
        if (event.recurrenceRule.isEmpty) {
          normalizedDates.add(normalizedDate(event.start));
          deltaDays.add(event.end.difference(event.start).inDays);
        } else {
          for (final date in getDateInRecurrence(
            event.recurrenceRule,
            event.start,
          )) {
            normalizedDates.add(normalizedDate(date));
            deltaDays.add(event.end.difference(event.start).inDays);
          }
        }
        for (int i = 0; i < normalizedDates.length; i++) {
          final DateTime maxDate =
              normalizedNow.compareTo(normalizedDates[i]) <= 0
              ? normalizedDates[i]
              : normalizedNow;
          String formattedDelay = formatDelayToToday(maxDate, normalizedNow);
          final e = event.copyWith(
            start: mergeDates(normalizedDates[i], event.start),
            end: mergeDates(
              normalizedDates[i].add(Duration(days: deltaDays[i])),
              event.end,
            ),
          );
          if (e.end.isAfter(now)) {
            dateTitle[formattedDelay] = normalizedDates[i];
            if (sortedEventList.containsKey(formattedDelay)) {
              final index = sortedEventList[formattedDelay]!.indexWhere(
                (element) => element.start.isAfter(e.start),
              );
              if (index == -1) {
                sortedEventList[formattedDelay]!.add(e);
              } else {
                sortedEventList[formattedDelay]!.insert(index, e);
              }
            } else {
              sortedEventList[formattedDelay] = [e];
            }
          }
        }
      }
      final sortedKeys = sortedEventList.keys.toList(growable: false)
        ..sort((k1, k2) => dateTitle[k1]!.compareTo(dateTitle[k2]!));
      return {for (var k in sortedKeys) k: sortedEventList[k]!};
    },
    orElse: () => {},
  );
});
