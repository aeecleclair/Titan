import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/home/providers/selected_day.dart';
import 'package:titan/home/tools/constants.dart';

class DayCard extends HookConsumerWidget {
  final bool isToday;
  final DateTime day;
  final int numberOfEvent, index;
  final void Function() onTap;
  const DayCard({
    super.key,
    required this.day,
    required this.isToday,
    required this.numberOfEvent,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDayNotifier = ref.watch(selectedDayProvider.notifier);
    final selectedDay = ref.watch(selectedDayProvider);
    return GestureDetector(
      onTap: () {
        selectedDayNotifier.setSelected(index);
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 10.0,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          border: Border.all(
            color: (selectedDay == index && !isToday)
                ? Colors.black
                : Colors.transparent,
            width: 2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isToday
                ? [HomeColorConstants.gradient1, HomeColorConstants.gradient2]
                : [Colors.white, Colors.grey.shade100],
          ),
          boxShadow: [
            BoxShadow(
              color: isToday
                  ? HomeColorConstants.gradient2.withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        height: 100,
        width: 70,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 35,
              child: Text(
                day.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 15,
              child: Text(
                HomeTextConstants.translateDayShort[DateFormat(
                  'E',
                ).format(day)]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 25,
              child: numberOfEvent < 6
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < numberOfEvent; i++)
                          SizedBox(
                            width: 7,
                            child: Icon(
                              Icons.circle,
                              color: isToday ? Colors.white : Colors.black,
                              size: 5,
                            ),
                          ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$numberOfEvent",
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
