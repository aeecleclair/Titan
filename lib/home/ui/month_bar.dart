import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/home/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  final ScrollController scrollController;
  final List<DateTime> days;
  final int offset;
  const MonthBar(
      {super.key,
      required this.scrollController,
      required this.days,
      required this.offset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final day = useState(now);

    final currentMonth = useState(day.value.month);
    scrollController.addListener(() {
      day.value = days[(scrollController.position.pixels - 15) ~/ 86 + offset];
      currentMonth.value = day.value.month;
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
