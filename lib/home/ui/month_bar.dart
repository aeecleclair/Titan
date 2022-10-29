import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/home/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<DateTime>> days;
  final ValueNotifier<int> numberDay;
  const MonthBar(
      {super.key,
      required this.scrollController,
      required this.days,
      required this.numberDay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    final currentMonth = useState(now.month);

    scrollController.addListener(() {
      now = days.value[(scrollController.position.pixels -
              15 +
              MediaQuery.of(context).size.width / 2) ~/
          86];
      if (now.month != currentMonth.value) {
        currentMonth.value = now.month;
      }
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 50) {
        numberDay.value += 10;
        // } else if (scrollController.position.pixels <
        //     scrollController.position.minScrollExtent + 50) {
        //   numberDay.value += 1;
        //   offset.value += 1;
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
