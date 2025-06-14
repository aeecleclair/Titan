import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/home/providers/days_provider.dart';
import 'package:titan/home/providers/number_day_provider.dart';
import 'package:titan/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  final ScrollController scrollController;
  final double width;
  const MonthBar({
    super.key,
    required this.scrollController,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberDayNotifier = ref.watch(numberDayProvider.notifier);
    final currentDay = useState(DateTime.now());
    final currentMonth = useState(currentDay.value.month);
    final days = ref.watch(daysProvider);

    scrollController.addListener(() {
      currentDay.value = days[(scrollController.position.pixels) ~/ 86];
      if (currentDay.value.month != currentMonth.value) {
        currentMonth.value = currentDay.value.month;
      }
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 50) {
        numberDayNotifier.add(1);
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                final deltaDay =
                    DateTime(
                      currentDay.value.year,
                      currentDay.value.month - 1,
                      0,
                    ).day -
                    currentDay.value.day;
                scrollController.animateTo(
                  scrollController.position.pixels - deltaDay * 86 - width / 2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                getMonth((currentMonth.value - 1) % 12),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Text(
          getMonth(currentMonth.value % 12),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                final deltaDay =
                    DateTime(
                      currentDay.value.year,
                      currentDay.value.month + 1,
                      0,
                    ).day -
                    currentDay.value.day;
                scrollController.animateTo(
                  scrollController.position.pixels +
                      (deltaDay - 1) * 86 -
                      5 +
                      width / 2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                getMonth((currentMonth.value + 1) % 12),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ],
    );
  }
}
