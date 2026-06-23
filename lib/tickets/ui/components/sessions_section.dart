import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tickets/ui/components/edit_ticket_event_helpers.dart';
import 'package:titan/tickets/ui/components/read_only_banner.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class SessionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  const SessionsSection({
    super.key,
    required this.event,
    required this.onEventUpdated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
    final editNotifier = ref.watch(ticketEventEditProvider.notifier);

    Future<void> addSession() async {
      final nameController = TextEditingController();
      final dateController = TextEditingController();
      final quotaController = TextEditingController();

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.ticketsAddSession),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextEntry(
                label: l10n.ticketsSessionLabelNumbered(
                  event.sessions.length + 1,
                ),
                controller: nameController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              DateEntry(
                label: l10n.ticketsDateLabel,
                controller: dateController,
                onTap: () => getFullDate(ctx, dateController),
              ),
              const SizedBox(height: 8),
              TextEntry(
                label: l10n.ticketsQuotaLabel,
                controller: quotaController,
                keyboardType: TextInputType.number,
                canBeEmpty: true,
                onChanged: (_) {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.globalCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.ticketsSave),
            ),
          ],
        ),
      );

      if (confirmed != true || !context.mounted) return;
      if (nameController.text.trim().isEmpty || dateController.text.isEmpty) {
        return;
      }

      final session = Session(
        id: '',
        name: nameController.text.trim(),
        startDatetime: DateTime.parse(
          processDateBackWithHourMaybe(dateController.text, locale.toString()),
        ),
        quota: quotaController.text.isEmpty
            ? null
            : int.tryParse(quotaController.text),
      );

      await tokenExpireWrapper(ref, () async {
        final created = await editNotifier.addSession(event.id, session);
        if (!context.mounted) return;
        if (created != null) {
          displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
          onEventUpdated(
            event.copyWith(sessions: [...event.sessions, created]),
          );
        } else {
          displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
        }
      });
    }

    return SectionCard(
      title: l10n.ticketsSessions,
      child: Column(
        children: [
          ...event.sessions.map((session) {
            final locked = session.hasSales;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              color: locked ? Colors.grey.shade100 : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: ColorConstants.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (locked) const ReadOnlyBanner(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            session.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (session.disabled)
                          Text(
                            l10n.ticketsDisabled,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatter.format(session.startDatetime),
                      style: TextStyle(color: ColorConstants.tertiary),
                    ),
                    Text(
                      '${l10n.ticketsQuotaLabel}: ${session.quota?.toString() ?? l10n.ticketsUnlimited}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    Text(
                      '${session.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${session.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    SwitchListTile(
                      value: !session.disabled,
                      onChanged: (value) => _toggleSessionDisabled(
                        context,
                        ref,
                        event,
                        session,
                        !value,
                        onEventUpdated,
                      ),
                      title: Text(
                        session.disabled
                            ? l10n.ticketsSessionDeactivated
                            : l10n.ticketsSessionActivated,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (!locked) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () => _showSessionEditDialog(
                              context,
                              ref,
                              event,
                              session,
                              onEventUpdated,
                            ),
                            child: Text(l10n.ticketsEdit),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () async {
                              if (!await showDeleteConfirm(context, ref)) {
                                return;
                              }
                              if (!context.mounted) return;
                              await tokenExpireWrapper(ref, () async {
                                final success = await editNotifier
                                    .deleteSession(event.id, session.id);
                                if (!context.mounted) return;
                                if (success) {
                                  displayToast(
                                    context,
                                    TypeMsg.msg,
                                    l10n.ticketsEditSuccess,
                                  );
                                  onEventUpdated(
                                    _withoutSession(event, session.id),
                                  );
                                } else {
                                  showEditError(
                                    context,
                                    ref,
                                    l10n,
                                    fallbackDueSales:
                                        l10n.ticketsCannotDeleteDueSales,
                                  );
                                }
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorConstants.error,
                            ),
                            child: Text(l10n.ticketsDelete),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: addSession,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddSession),
          ),
        ],
      ),
    );
  }
}

Future<void> _showSessionEditDialog(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Session session,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context);
  final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
  final editNotifier = ref.read(ticketEventEditProvider.notifier);

  final nameController = TextEditingController(text: session.name);
  final dateController = TextEditingController(
    text: dateFormatter.format(session.startDatetime),
  );
  final quotaController = TextEditingController(
    text: session.quota?.toString() ?? '',
  );
  var disabled = session.disabled;

  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: StatefulBuilder(
      builder: (modalContext, setState) => BottomModalTemplate(
        title: l10n.ticketsEdit,
        child: Column(
          children: [
            TextEntry(
              label: l10n.ticketsSessionLabel,
              controller: nameController,
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            DateEntry(
              label: l10n.ticketsDateLabel,
              controller: dateController,
              onTap: () => getFullDate(modalContext, dateController),
            ),
            const SizedBox(height: 8),
            TextEntry(
              label: l10n.ticketsQuotaLabel,
              controller: quotaController,
              keyboardType: TextInputType.number,
              canBeEmpty: true,
              onChanged: (_) {},
            ),
            SwitchListTile(
              value: !disabled,
              onChanged: (v) => setState(() => disabled = !v),
              title: Text(
                disabled
                    ? l10n.ticketsSessionDeactivated
                    : l10n.ticketsSessionActivated,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            Button(
              text: l10n.ticketsSaveChanges,
              onPressed: () async {
                Navigator.pop(modalContext);
                if (!context.mounted) return;

                final updated = session.copyWith(
                  name: nameController.text.trim(),
                  startDatetime: DateTime.parse(
                    processDateBackWithHourMaybe(
                      dateController.text,
                      locale.toString(),
                    ),
                  ),
                  quota: quotaController.text.isEmpty
                      ? null
                      : int.tryParse(quotaController.text),
                  disabled: disabled,
                );

                await tokenExpireWrapper(ref, () async {
                  final success = await editNotifier.updateSession(
                    event.id,
                    updated,
                  );
                  if (!context.mounted) return;
                  if (success) {
                    displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
                    onEventUpdated(_withSession(event, updated));
                  } else {
                    final error = ref.read(ticketEventEditProvider).error;
                    displayToast(
                      context,
                      TypeMsg.error,
                      error is AppException
                          ? error.message
                          : l10n.ticketsUpdateError,
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    ),
  );

  nameController.dispose();
  dateController.dispose();
  quotaController.dispose();
}

TicketEvent _withSession(TicketEvent event, Session session) {
  return event.copyWith(
    sessions: event.sessions
        .map((s) => s.id == session.id ? session : s)
        .toList(),
  );
}

TicketEvent _withoutSession(TicketEvent event, String sessionId) {
  return event.copyWith(
    sessions: event.sessions.where((s) => s.id != sessionId).toList(),
  );
}

Future<void> _toggleSessionDisabled(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Session session,
  bool disabled,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final editNotifier = ref.read(ticketEventEditProvider.notifier);
  await tokenExpireWrapper(ref, () async {
    final success = await editNotifier.updateSessionDisabled(
      event.id,
      session.id,
      disabled,
    );
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      onEventUpdated(_withSession(event, session.copyWith(disabled: disabled)));
    } else {
      showEditError(context, ref, l10n);
    }
  });
}
