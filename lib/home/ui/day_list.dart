import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/day_sorted_event_list_provider.dart';
import 'package:myecl/event/providers/sorted_event_list_provider.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/home/providers/days_provider.dart';
import 'package:myecl/home/providers/number_day_provider.dart';
import 'package:myecl/home/ui/day_card.dart';
import 'package:myecl/tools/functions.dart';

class DayList extends HookConsumerWidget {
  final ScrollController scrollController, daysEventScrollController;
  const DayList(this.scrollController, this.daysEventScrollController,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needReload = useState(false);
    final numberDay = ref.watch(numberDayProvider);
    final daySortedEventList = ref.watch(daySortedEventListProvider);
    final sortedEventList = ref.watch(sortedEventListProvider);
    final days = ref.watch(daysProvider);

    DateTime now = normalizedDate(DateTime.now());

    Map<String, double> widgetPositions = {};
    if (sortedEventList.keys.isNotEmpty) {
      widgetPositions.addAll({formatDelayToToday(days[0], now): 0});
      for (int i = 0; i < days.length - 1; i++) {
        DateTime date = days[i];
        int height = 0;
        String formattedDate = formatDelayToToday(date, now);
        String formattedNextDate = formatDelayToToday(days[i + 1], now);

        if (formattedNextDate != formattedDate) {
          if (sortedEventList.keys.contains(formattedDate)) {
            height = 18 + 170 * sortedEventList[formattedDate]!.length;
          }
        }
        widgetPositions[formattedNextDate] =
            height + widgetPositions[formattedDate]!;
      }
    }

    return SizedBox(
      height: 125,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        itemCount: numberDay + 2,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0 || i == days.length + 1) {
            return const SizedBox(width: 15);
          }
          final day = days[i - 1];
          return DayCard(
            isToday: i == 1,
            day: day,
            numberOfEvent: daySortedEventList.keys.contains(day)
                ? daySortedEventList[day]!.length
                : 0,
            index: i - 1,
            onTap: () {
              needReload.value = true;
              daysEventScrollController.animateTo(
                  widgetPositions[formatDelayToToday(day, now)] ?? 0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
          );
        },
      ),
    );
  }
}
