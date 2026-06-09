import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class SessionCardController {
  SessionCardController()
    : entries = [
        {
          'label': TextEditingController(),
          'date': TextEditingController(),
          'quota': TextEditingController(),
        },
      ];

  final List<Map<String, TextEditingController>> entries;

  void addEntry() {
    entries.add({
      'label': TextEditingController(),
      'date': TextEditingController(),
      'quota': TextEditingController(),
    });
  }

  void removeEntry(int index) {
    if (entries.length <= 1) return;
    for (final controller in entries[index].values) {
      controller.dispose();
    }
    entries.removeAt(index);
  }

  void dispose() {
    for (final entry in entries) {
      for (final controller in entry.values) {
        controller.dispose();
      }
    }
    entries.clear();
  }

  List<Session> buildSessions(String locale) {
    DateTime? parseSessionDate(String dateText) {
      if (dateText.trim().isEmpty) return null;
      try {
        return DateTime.parse(
          processDateBackWithHourMaybe(dateText, locale),
        );
      } catch (_) {
        return null;
      }
    }

    return entries
        .map(
          (e) => Session(
            id: '',
            name: e['label']!.text.trim(),
            startDatetime:
                parseSessionDate(e['date']!.text) ?? DateTime.now(),
            quota: int.tryParse(e['quota']!.text.trim()),
          ),
        )
        .toList();
  }
}

class SessionCard extends HookWidget {
  const SessionCard({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final SessionCardController controller;
  final void Function(List<Session> sessions)? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final refreshCounter = useState(0);

    void notify() {
      refreshCounter.value++;
      onChanged?.call(controller.buildSessions(locale.toString()));
    }

    final entries = controller.entries;
    final _ = refreshCounter.value;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorConstants.secondary.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.ticketsSessions,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              entries.length,
              (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextEntry(
                              label: l10n.ticketsSessionLabelNumbered(i + 1),
                              controller: entries[i]['label']!,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (_) => notify(),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DateEntry(
                                    label: l10n.ticketsDateLabel,
                                    controller: entries[i]['date']!,
                                    onTap: () async {
                                      await getFullDate(
                                        context,
                                        entries[i]['date']!,
                                      );
                                      notify();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: TextEntry(
                                    label: l10n.ticketsQuotaLabel,
                                    controller: entries[i]['quota']!,
                                    keyboardType: TextInputType.number,
                                    isInt: true,
                                    onChanged: (_) => notify(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (entries.length > 1)
                        IconButton(
                          icon: HeroIcon(
                            HeroIcons.minusCircle,
                            size: 22,
                            color: ColorConstants.error,
                          ),
                          onPressed: () {
                            controller.removeEntry(i);
                            notify();
                          },
                        )
                      else
                        const SizedBox(width: 48),
                    ],
                  ),
                ),
            ),
            TextButton.icon(
              onPressed: () {
                controller.addEntry();
                notify();
              },
              icon: const HeroIcon(HeroIcons.plus, size: 18),
              label: Text(l10n.ticketsAddSession),
              style: TextButton.styleFrom(
                foregroundColor: ColorConstants.main,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
