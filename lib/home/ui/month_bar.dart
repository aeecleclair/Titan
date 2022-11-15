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
    final currentMonth =
        useState(DateTime.now().add(const Duration(days: 1)).month);
    final days = ref.watch(daysProvider);

    scrollController.addListener(() {
      int m =
          days[(scrollController.position.pixels - 15 + width / 2) ~/ 86].month;
      if (m != currentMonth.value) {
        currentMonth.value = m;
      }
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 50) {
        numberDayNotifier.add(7);
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
            Text(getMonth((currentMonth.value - 1) % 12),
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 205, 205, 205))),
          ],
        ),
        Text(
          getMonth(currentMonth.value % 12),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(getMonth((currentMonth.value + 1) % 12),
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 205, 205, 205))),
            const SizedBox(
              width: 30,
            ),
          ],
        )
      ],
    );
  }
}
