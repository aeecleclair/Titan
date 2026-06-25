import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/session_form_entry.dart';
import 'package:titan/tickets/providers/sessions_form_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class SessionCard extends HookConsumerWidget {
  const SessionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sessionsForm = ref.watch(sessionsFormProvider);
    final sessionsFormNotifier = ref.read(sessionsFormProvider.notifier);
    final entries = sessionsForm.entries;

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
              (i) => _SessionEntryRow(
                key: ValueKey('session-entry-$i-${entries.length}'),
                index: i,
                entry: entries[i],
                canRemove: entries.length > 1,
                onRemove: () => sessionsFormNotifier.removeEntry(i),
              ),
            ),
            TextButton.icon(
              onPressed: sessionsFormNotifier.addEntry,
              icon: const HeroIcon(HeroIcons.plus, size: 18),
              label: Text(l10n.ticketsAddSession),
              style: TextButton.styleFrom(foregroundColor: ColorConstants.main),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionEntryRow extends HookConsumerWidget {
  const _SessionEntryRow({
    super.key,
    required this.index,
    required this.entry,
    required this.canRemove,
    required this.onRemove,
  });

  final int index;
  final SessionFormEntry entry;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final sessionsFormNotifier = ref.read(sessionsFormProvider.notifier);
    final labelController = useTextEditingController(text: entry.label);
    final quotaController = useTextEditingController(text: entry.quota);
    final dateController = useTextEditingController(
      text: entry.startDatetime != null
          ? DateFormat.yMd(locale).add_Hm().format(entry.startDatetime!)
          : '',
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextEntry(
                  label: l10n.ticketsSessionLabelNumbered(index + 1),
                  controller: labelController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) =>
                      sessionsFormNotifier.updateLabel(index, value),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DateEntry(
                        label: l10n.ticketsDateLabel,
                        controller: dateController,
                        onTap: () async {
                          final picked = await pickFullDate(
                            context,
                            initialDate: entry.startDatetime,
                          );
                          if (picked == null) return;
                          sessionsFormNotifier.updateStartDatetime(
                            index,
                            picked,
                          );
                          dateController.text = DateFormat.yMd(
                            locale,
                          ).add_Hm().format(picked);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextEntry(
                        label: l10n.ticketsQuotaLabel,
                        controller: quotaController,
                        keyboardType: TextInputType.number,
                        isInt: true,
                        onChanged: (value) =>
                            sessionsFormNotifier.updateQuota(index, value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (canRemove)
            IconButton(
              icon: HeroIcon(
                HeroIcons.minusCircle,
                size: 22,
                color: ColorConstants.error,
              ),
              onPressed: onRemove,
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
