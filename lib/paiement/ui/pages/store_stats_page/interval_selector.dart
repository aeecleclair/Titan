import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/paiement/providers/selected_interval_provider.dart';
import 'package:titan/paiement/providers/selected_store_history.dart';
import 'package:titan/paiement/providers/selected_store_provider.dart';

class IntervalSelector extends ConsumerWidget {
  const IntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedHistoryNotifier = ref.read(sellerHistoryProvider.notifier);
    final selectedInterval = ref.watch(selectedIntervalProvider);
    final selectedIntervalNotifier = ref.read(
      selectedIntervalProvider.notifier,
    );

    Future<DateTime?> getDate(DateTime initialDate) async {
      return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: now.subtract(const Duration(days: 365 * 5)),
        lastDate: now,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff017f80),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
      );
    }

    Future<TimeOfDay?> getTime(DateTime initialDate) async {
      return await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff017f80),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff017f80).withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    DateFormat(
                      "dd MMM yyyy",
                      "fr_FR",
                    ).format(selectedInterval.start),
                    style: TextStyle(
                      color: const Color(0xff204550),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                onTap: () async {
                  final date = await getDate(selectedInterval.start);
                  if (date != null) {
                    selectedIntervalNotifier.updateStart(date);
                    await selectedHistoryNotifier.getHistory(
                      selectedStore.id,
                      date,
                      selectedInterval.end,
                    );
                  }
                },
              ),
              SizedBox(width: 5),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff017f80).withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    DateFormat("HH:mm", "fr_FR").format(selectedInterval.start),
                    style: TextStyle(
                      color: const Color(0xff204550),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                onTap: () async {
                  final time = await getTime(selectedInterval.start);
                  if (time != null) {
                    final date = DateTime(
                      selectedInterval.start.year,
                      selectedInterval.start.month,
                      selectedInterval.start.day,
                      time.hour,
                      time.minute,
                    );
                    selectedIntervalNotifier.updateStart(date);
                    await selectedHistoryNotifier.getHistory(
                      selectedStore.id,
                      date,
                      selectedInterval.end,
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(width: 5),
          HeroIcon(
            HeroIcons.arrowRight,
            color: const Color(0xff204550),
            size: 20,
          ),
          SizedBox(width: 5),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff017f80).withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    DateFormat(
                      "dd MMM yyyy",
                      "fr_FR",
                    ).format(selectedInterval.end),
                    style: TextStyle(
                      color: const Color(0xff204550),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                onTap: () async {
                  final date = await getDate(selectedInterval.end);
                  if (date != null) {
                    selectedIntervalNotifier.updateEnd(date);
                    await selectedHistoryNotifier.getHistory(
                      selectedStore.id,
                      selectedInterval.start,
                      date,
                    );
                  }
                },
              ),
              SizedBox(width: 5),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff017f80).withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    DateFormat("HH:mm", "fr_FR").format(selectedInterval.end),
                    style: TextStyle(
                      color: const Color(0xff204550),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                onTap: () async {
                  final time = await getTime(selectedInterval.end);
                  if (time != null) {
                    final date = DateTime(
                      selectedInterval.end.year,
                      selectedInterval.end.month,
                      selectedInterval.end.day,
                      time.hour,
                      time.minute,
                    );
                    selectedIntervalNotifier.updateEnd(date);
                    await selectedHistoryNotifier.getHistory(
                      selectedStore.id,
                      selectedInterval.start,
                      date,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
