import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class SessionCard extends HookWidget {
  const SessionCard({super.key, required this.onChanged});

  final void Function(List<Session> sessions) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = useState<List<Map<String, TextEditingController>>>([
      _newEntry(),
    ]);

    void notify() => onChanged(
      entries.value
          .map(
            (e) => Session(
              id: '',
              name: e['label']!.text,
              startDatetime:
                  DateTime.tryParse(e['date']!.text) ?? DateTime.now(),
              quota: int.tryParse(e['quota']!.text) ?? 0,
            ),
          )
          .toList(),
    );

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
              l10n.shotgunSessions,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              entries.value.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ligne 1: Nom de la session
                          TextEntry(
                            label: l10n.shotgunSessionLabelNumbered(i + 1),
                            controller: entries.value[i]['label']!,
                            onChanged: (_) => notify(),
                          ),
                          const SizedBox(height: 8),
                          // Ligne 2: Date et Quota
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: DateEntry(
                                  label: l10n.shotgunDateLabel,
                                  controller: entries.value[i]['date']!,
                                  onTap: () => getFullDate(
                                    context,
                                    entries.value[i]['date']!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: TextEntry(
                                  label: l10n.shotgunQuotaLabel,
                                  controller: entries.value[i]['quota']!,
                                  onChanged: (_) => notify(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (entries.value.length > 1)
                      IconButton(
                        icon: HeroIcon(
                          HeroIcons.minusCircle,
                          size: 22,
                          color: ColorConstants.error,
                        ),
                        onPressed: () {
                          entries.value = [...entries.value]..removeAt(i);
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
                entries.value = [...entries.value, _newEntry()];
                notify();
              },
              icon: const HeroIcon(HeroIcons.plus, size: 18),
              label: Text(l10n.shotgunAddSession),
              style: TextButton.styleFrom(foregroundColor: ColorConstants.main),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, TextEditingController> _newEntry() => {
    'label': TextEditingController(),
    'date': TextEditingController(),
    'quota': TextEditingController(),
  };
}
