import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/home/providers/days_provider.dart';
import 'package:myecl/home/providers/number_day_provider.dart';
import 'package:myecl/home/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  final ScrollController scrollController;
  final double width;
  const MonthBar(
      {super.key, required this.scrollController, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberDayNotifier = ref.watch(numberDayProvider.notifier);
    final numberDay = ref.watch(numberDayProvider);
    final currentDay = useState(DateTime.now());
    final currentMonth = useState(currentDay.value.month);
    final days = ref.watch(daysProvider);
    final addedDays = useState(false);
    final lastNumberDay = useState(numberDay);

    scrollController.addListener(() {
      int currentDayIndex = (scrollController.position.pixels - 15) ~/ 86;
      currentDay.value = days[currentDayIndex];
      if (currentDay.value.month != currentMonth.value) {
        currentMonth.value = currentDay.value.month;
      }
      if (currentDayIndex > numberDay - 20 && !addedDays.value) {
        numberDayNotifier.add(1);
        addedDays.value = true;
        lastNumberDay.value = numberDay;
      }
      if (lastNumberDay.value < numberDay && addedDays.value) {
        addedDays.value = false;
        lastNumberDay.value = numberDay;
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                final deltaDay = DateTime(currentDay.value.year,
                            currentDay.value.month - 1, 0)
                        .day -
                    currentDay.value.day;
                scrollController.animateTo(
                    scrollController.position.pixels - deltaDay * 86 - 15,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Text(getMonth((currentMonth.value - 1) % 12),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 205, 205, 205))),
            ),
          ],
        ),
        Text(
          getMonth(currentMonth.value % 12),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                final deltaDay = DateTime(currentDay.value.year,
                            currentDay.value.month + 1, 0)
                        .day -
                    currentDay.value.day;
                scrollController.animateTo(
                    scrollController.position.pixels + deltaDay * 86 - 15,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Text(getMonth((currentMonth.value + 1) % 12),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 205, 205, 205))),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        )
      ],
    );
  }
}
