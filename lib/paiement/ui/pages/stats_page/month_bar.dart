import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  const MonthBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDay = useState(DateTime.now());
    final currentMonth = useState(currentDay.value.month);

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
                currentMonth.value = (currentMonth.value - 1) % 12;
              },
              child: Text(getMonth((currentMonth.value - 1) % 12),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 149, 149, 149))),
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
                currentMonth.value = (currentMonth.value + 1) % 12;
              },
              child: Text(getMonth((currentMonth.value + 1) % 12),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 149, 149, 149))),
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
