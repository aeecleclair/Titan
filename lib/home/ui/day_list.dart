import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/providers/day_sorted_event_list_provider.dart';
import 'package:titan/event/providers/sorted_event_list_provider.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/home/providers/days_provider.dart';
import 'package:titan/home/providers/number_day_provider.dart';
import 'package:titan/home/ui/day_card.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

class DayList extends HookConsumerWidget {
  final ScrollController scrollController, daysEventScrollController;
  const DayList(
    this.scrollController,
    this.daysEventScrollController, {
    super.key,
  });

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

    return HorizontalListView.builder(
      height: 125,
      items: days,
      length: numberDay,
      scrollController: scrollController,
      itemBuilder: (context, day, i) => DayCard(
        isToday: i == 0,
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
            curve: Curves.decelerate,
          );
        },
      ),
    );
  }
}
