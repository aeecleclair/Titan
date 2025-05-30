import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/providers/selected_interval_provider.dart';

class IntervalSelector extends ConsumerWidget {
  const IntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Du",
                style: TextStyle(
                  color: const Color(0xff204550),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
                    DateFormat(
                      "dd MMMM yyyy",
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
                  }
                },
              ),
              SizedBox(width: 5),
              Text(
                "au",
                style: TextStyle(
                  color: const Color(0xff204550),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
                    DateFormat(
                      "dd MMMM yyyy",
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
                  }
                },
              ),
              Spacer(),
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
                  child: HeroIcon(
                    HeroIcons.arrowPath,
                    color: const Color(0xff204550),
                    size: 20,
                  ),
                ),
                onTap: () async {
                  selectedIntervalNotifier.clearSelectedInterval();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
