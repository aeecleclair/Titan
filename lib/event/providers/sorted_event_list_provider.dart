import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';

final sortedEventListProvider = Provider<Map<DateTime, List<Event>>>((ref) {
  final eventList = ref.watch(eventListProvider);
  final sortedEventList = <DateTime, List<Event>>{};
  return eventList.when(
      data: (events) {
        for (final event in events) {
          DateTime normalizedDate = DateTime(event.start.year,
              event.start.month, event.start.day, 0, 0, 0, 0, 0);
          if (sortedEventList.containsKey(normalizedDate)) {
            final index = sortedEventList[normalizedDate]!
                .indexWhere((element) => element.start.isAfter(event.start));
            if (index == -1) {
              sortedEventList[normalizedDate]!.add(event);
            } else {
              sortedEventList[normalizedDate]!.insert(index, event);
            }
          } else {
            sortedEventList[normalizedDate] = [event];
          }
        }
        return sortedEventList;
      },
      loading: () => {},
      error: (error, stack) => {});
});
