import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      final result = await showDialog<_SessionFormResult>(
        context: context,
        builder: (ctx) =>
            _AddSessionDialog(sessionIndex: event.sessions.length + 1),
      );

      if (result == null || !context.mounted) return;
      if (result.name.isEmpty || result.dateText.isEmpty) return;

      final session = Session(
        id: '',
        name: result.name,
        startDatetime: DateTime.parse(
          processDateBackWithHourMaybe(result.dateText, locale.toString()),
        ),
        quota: result.quotaText.isEmpty ? null : int.tryParse(result.quotaText),
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
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: _SessionEditModal(
      parentContext: context,
      event: event,
      session: session,
      onEventUpdated: onEventUpdated,
    ),
  );
}

class _SessionFormResult {
  const _SessionFormResult({
    required this.name,
    required this.dateText,
    required this.quotaText,
  });

  final String name;
  final String dateText;
  final String quotaText;
}

class _AddSessionDialog extends HookConsumerWidget {
  const _AddSessionDialog({required this.sessionIndex});

  final int sessionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController();
    final dateController = useTextEditingController();
    final quotaController = useTextEditingController();

    return AlertDialog(
      title: Text(l10n.ticketsAddSession),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextEntry(
            label: l10n.ticketsSessionLabelNumbered(sessionIndex),
            controller: nameController,
            onChanged: (_) {},
          ),
          const SizedBox(height: 8),
          DateEntry(
            label: l10n.ticketsDateLabel,
            controller: dateController,
            onTap: () => getFullDate(context, dateController),
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
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.globalCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            _SessionFormResult(
              name: nameController.text.trim(),
              dateText: dateController.text,
              quotaText: quotaController.text,
            ),
          ),
          child: Text(l10n.ticketsSave),
        ),
      ],
    );
  }
}

class _SessionEditModal extends HookConsumerWidget {
  const _SessionEditModal({
    required this.parentContext,
    required this.event,
    required this.session,
    required this.onEventUpdated,
  });

  final BuildContext parentContext;
  final TicketEvent event;
  final Session session;
  final void Function(TicketEvent) onEventUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
    final editNotifier = ref.read(ticketEventEditProvider.notifier);
    final nameController = useTextEditingController(text: session.name);
    final dateController = useTextEditingController(
      text: dateFormatter.format(session.startDatetime),
    );
    final quotaController = useTextEditingController(
      text: session.quota?.toString() ?? '',
    );
    final disabled = useState(session.disabled);

    return BottomModalTemplate(
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
            onTap: () => getFullDate(context, dateController),
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
            value: !disabled.value,
            onChanged: (v) => disabled.value = !v,
            title: Text(
              disabled.value
                  ? l10n.ticketsSessionDeactivated
                  : l10n.ticketsSessionActivated,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          Button(
            text: l10n.ticketsSaveChanges,
            onPressed: () async {
              Navigator.pop(context);
              if (!parentContext.mounted) return;

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
                disabled: disabled.value,
              );

              await tokenExpireWrapper(ref, () async {
                final success = await editNotifier.updateSession(
                  event.id,
                  updated,
                );
                if (!parentContext.mounted) return;
                if (success) {
                  displayToast(
                    parentContext,
                    TypeMsg.msg,
                    l10n.ticketsEditSuccess,
                  );
                  onEventUpdated(_withSession(event, updated));
                } else {
                  final error = ref.read(ticketEventEditProvider).error;
                  displayToast(
                    parentContext,
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
    );
  }
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
