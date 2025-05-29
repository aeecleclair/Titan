import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';
import 'package:myecl/paiement/tools/functions.dart';

class MonthBar extends HookConsumerWidget {
  const MonthBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonth = ref.watch(selectedMonthProvider);
    final currentMonthNotifier = ref.watch(selectedMonthProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                final isPreviousYear = currentMonth.month == 0;
                currentMonthNotifier.updateSelectedMonth(
                  DateTime(
                    currentMonth.year - (isPreviousYear ? 1 : 0),
                    (currentMonth.month - 1) % 12,
                  ),
                );
              },
              child: Text(
                getMonth((currentMonth.month - 1) % 12),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 149, 149, 149),
                ),
              ),
            ),
          ],
        ),
        Text(
          getMonth(currentMonth.month % 12),
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
                final isNextYear = currentMonth.month == 11;
                currentMonthNotifier.updateSelectedMonth(
                  DateTime(
                    currentMonth.year + (isNextYear ? 1 : 0),
                    (currentMonth.month + 1) % 12,
                  ),
                );
              },
              child: Text(
                getMonth((currentMonth.month + 1) % 12),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 149, 149, 149),
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
