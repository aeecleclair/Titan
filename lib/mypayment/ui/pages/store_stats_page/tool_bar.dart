import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/mypayment/providers/history_export_csv_provider.dart';
import 'package:titan/mypayment/providers/selected_interval_provider.dart';
import 'package:titan/mypayment/providers/selected_store_history.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedHistoryNotifier = ref.read(sellerHistoryProvider.notifier);
    final selectedInterval = ref.watch(selectedIntervalProvider);
    final selectedIntervalNotifier = ref.read(
      selectedIntervalProvider.notifier,
    );
    final isDarkTheme = ref.watch(themeProvider);

    void displayMyPaymentToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Widget builder(BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: MyPaymentColors(isDarkTheme).gradient1,
          ),
        ),
        child: child!,
      );
    }

    Future<DateTime?> getDate(DateTime initialDate) async {
      return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: now.subtract(const Duration(days: 365 * 5)),
        lastDate: now,
        builder: builder,
      );
    }

    Future<TimeOfDay?> getTime(DateTime initialDate) async {
      return await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: builder,
      );
    }

    return Column(
      children: [
        Padding(
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
                        color: MyPaymentColors(
                          isDarkTheme,
                        ).gradient1.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        DateFormat(
                          "dd MMM yyyy",
                          "fr_FR",
                        ).format(selectedInterval.start),
                        style: TextStyle(
                          color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
                        color: MyPaymentColors(
                          isDarkTheme,
                        ).gradient1.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        DateFormat(
                          "HH:mm",
                          "fr_FR",
                        ).format(selectedInterval.start),
                        style: TextStyle(
                          color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
                color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
                        color: MyPaymentColors(
                          isDarkTheme,
                        ).gradient1.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        DateFormat(
                          "dd MMM yyyy",
                          "fr_FR",
                        ).format(selectedInterval.end),
                        style: TextStyle(
                          color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
                        color: MyPaymentColors(
                          isDarkTheme,
                        ).gradient1.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        DateFormat(
                          "HH:mm",
                          "fr_FR",
                        ).format(selectedInterval.end),
                        style: TextStyle(
                          color: MyPaymentColors(isDarkTheme).secondaryGreen,
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
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () async {
            late final Uint8List csvBytes;

            try {
              csvBytes = await ref.read(
                historyExportCsvProvider(selectedStore).future,
              );
            } catch (e) {
              displayMyPaymentToastWithContext(TypeMsg.error, e.toString());
              return;
            }

            final fileName =
                "Store_history_${selectedStore.name.replaceAll(" ", "_")}";

            final path = kIsWeb
                ? await FileSaver.instance.saveFile(
                    name: fileName,
                    bytes: csvBytes,
                    ext: "csv",
                    mimeType: MimeType.csv,
                  )
                : await FileSaver.instance.saveAs(
                    name: fileName,
                    bytes: csvBytes,
                    ext: "csv",
                    mimeType: MimeType.csv,
                  );

            if (!context.mounted) return;

            if (path != null) {
              displayMyPaymentToastWithContext(
                TypeMsg.msg,
                "Exportation CSV réussie !",
              );
            }
          },
          icon: const Icon(Icons.download),
          label: const Text('Exporter CSV'),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyPaymentColors(isDarkTheme).gradient1,
            foregroundColor: MyPaymentColors.onGradient,
          ),
        ),
      ],
    );
  }
}
