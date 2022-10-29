import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/home/providers/days_provider.dart';
import 'package:myecl/home/providers/number_day_provider.dart';
import 'package:myecl/home/ui/day_card.dart';

class DayList extends HookConsumerWidget {
  final ScrollController scrollController, daysEventScrollController;
  final Map<DateTime, List<Event>> sortedEventList;
  const DayList(this.scrollController, this.daysEventScrollController,
      this.sortedEventList,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = useState(0.0);
    final needReload = useState(false);
    final numberDay = ref.watch(numberDayProvider);
    final days = ref.watch(daysProvider);

    Map<DateTime, double> widgetPositions = {};
    if (sortedEventList.keys.isNotEmpty) {
      widgetPositions.addAll({days[0]: 0});
      for (int i = 0; i < days.length - 1; i++) {
        DateTime date = days[i];
        int height = 0;
        if (sortedEventList.keys.contains(date)) {
          height = 50 + 180 * sortedEventList[date]!.length;
        }
        widgetPositions[days[i + 1]] = height + widgetPositions[days[i]]!;
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
            return const SizedBox(
              width: 15,
            );
          }
          final day = days[i - 1];
          return DayCard(
            isToday: i == 1,
            day: day,
            numberOfEvent: sortedEventList.keys.contains(day)
                ? sortedEventList[day]!.length
                : 0,
            index: i - 1,
            onTap: () {
              position.value = scrollController.position.pixels;
              needReload.value = true;
              daysEventScrollController.animateTo(widgetPositions[day] ?? 0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
          );
        },
      ),
    );
  }
}
