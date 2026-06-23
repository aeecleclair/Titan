import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/question.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/providers/store_tickets_list_provider.dart';
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tickets/providers/ticket_event_provider.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class EditTicketEventPage extends HookConsumerWidget {
  const EditTicketEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedTicketEventProvider);

    if (selectedEvent == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => QR.back());
      return const SizedBox.shrink();
    }

    final eventAsync = ref.watch(ticketEventByIdProvider(selectedEvent.id));

    return TicketTemplate(
      child: AsyncChild(
        value: eventAsync,
        builder: (context, event) => _EditTicketEventContent(event: event),
      ),
    );
  }
}

class _EditTicketEventContent extends HookConsumerWidget {
  final TicketEvent event;

  const _EditTicketEventContent({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
    final editNotifier = ref.watch(ticketEventEditProvider.notifier);
    final scrollController = useScrollController();

    void onEventUpdated(TicketEvent updated) {
      _updateTicketEventState(ref, updated);
    }

    Future<void> deleteEvent() async {
      if (event.ticketsSold + event.ticketsInCheckout > 0) {
        displayToast(context, TypeMsg.error, l10n.ticketsCannotDeleteDueSales);
        return;
      }

      if (!await _showDeleteConfirm(context, ref)) {
        return;
      }
      if (!context.mounted) return;

      await tokenExpireWrapper(ref, () async {
        final success = await editNotifier.deleteTicketEvent(event.id);
        if (!context.mounted) return;

        if (success) {
          ref.read(selectedTicketEventProvider.notifier).state = null;
          final storeId = event.storeId;
          if (storeId != null) {
            await ref
                .read(storeTicketEventListProvider.notifier)
                .loadStoreTicketEventList(storeId);
          }
          if (!context.mounted) return;
          displayToast(context, TypeMsg.msg, l10n.ticketsDeleteEventSuccess);
          QR.back();
        } else {
          _showEditError(
            context,
            ref,
            l10n,
            fallbackDueSales: l10n.ticketsCannotDeleteDueSales,
          );
        }
      });
    }

    final canDeleteEvent = event.ticketsSold + event.ticketsInCheckout == 0;

    return ScrollToHideNavbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.ticketsEditTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.title,
                    ),
                  ),
                ),
                TicketEventStatusChip(status: event.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              event.name,
              style: TextStyle(fontSize: 16, color: ColorConstants.tertiary),
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.ticketsGlobalStats}: ${event.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${event.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
              style: TextStyle(fontSize: 13, color: ColorConstants.onTertiary),
            ),
            const SizedBox(height: 24),
            _SectionCard(
              title: l10n.ticketsGeneralInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.ticketsPlacesLabel}: ${event.quota?.toString() ?? l10n.ticketsUnlimited}',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                  Text(
                    '${l10n.ticketsStartDateLabel}: ${dateFormatter.format(event.openDatetime)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                  Text(
                    '${l10n.ticketsEndDateLabel}: ${event.closeDatetime != null ? dateFormatter.format(event.closeDatetime!) : '-'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                  SwitchListTile(
                    value: !event.disabled,
                    onChanged: (value) => _toggleEventDisabled(
                      context,
                      ref,
                      event,
                      !value,
                      onEventUpdated,
                    ),
                    title: Text(
                      event.disabled
                          ? l10n.ticketsEventDeactivated
                          : l10n.ticketsEventActivated,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => _showGeneralInfoEditDialog(
                      context,
                      ref,
                      event,
                      onEventUpdated,
                    ),
                    child: Text(l10n.ticketsEdit),
                  ),
                  const SizedBox(height: 16),
                  if (!canDeleteEvent) const _ReadOnlyBanner(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: canDeleteEvent ? deleteEvent : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ColorConstants.error,
                      ),
                      child: Text(l10n.ticketsDeleteEvent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SessionsSection(event: event, onEventUpdated: onEventUpdated),
            const SizedBox(height: 16),
            _CategoriesSection(event: event, onEventUpdated: onEventUpdated),
            const SizedBox(height: 16),
            _QuestionsSection(event: event, onEventUpdated: onEventUpdated),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
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
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyBanner extends StatelessWidget {
  const _ReadOnlyBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        l10n.ticketsReadOnlyDueSales,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    );
  }
}

Future<bool> _showDeleteConfirm(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context)!;
  var confirmed = false;
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: ConfirmModal(
      title: l10n.ticketsDeleteConfirm,
      description: l10n.globalIrreversibleAction,
      onYes: () => confirmed = true,
    ),
  );
  return confirmed;
}

void _showEditError(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n, {
  String? fallbackDueSales,
  String? fallbackDueAnswers,
}) {
  final error = ref.read(ticketEventEditProvider).error;
  if (error is AppException) {
    final message = error.message;
    if (message.contains('checkouts or tickets') && fallbackDueSales != null) {
      displayToast(context, TypeMsg.error, fallbackDueSales);
      return;
    }
    if (message.contains('answers') && fallbackDueAnswers != null) {
      displayToast(context, TypeMsg.error, fallbackDueAnswers);
      return;
    }
    displayToast(context, TypeMsg.error, message);
    return;
  }
  displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
}

void _updateTicketEventState(WidgetRef ref, TicketEvent updated) {
  ref.read(ticketEventByIdProvider(updated.id).notifier).setEvent(updated);
  ref.read(selectedTicketEventProvider.notifier).state = updated;
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

TicketEvent _withCategory(TicketEvent event, Category category) {
  return event.copyWith(
    categories: event.categories
        .map((c) => c.id == category.id ? category : c)
        .toList(),
  );
}

TicketEvent _withoutCategory(TicketEvent event, String categoryId) {
  return event.copyWith(
    categories: event.categories.where((c) => c.id != categoryId).toList(),
  );
}

TicketEvent _withQuestion(TicketEvent event, Question question) {
  return event.copyWith(
    questions: event.questions
        .map((q) => q.id == question.id ? question : q)
        .toList(),
  );
}

TicketEvent _withoutQuestion(TicketEvent event, String questionId) {
  return event.copyWith(
    questions: event.questions.where((q) => q.id != questionId).toList(),
  );
}

Future<void> _showGeneralInfoEditDialog(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context);
  final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
  final editNotifier = ref.read(ticketEventEditProvider.notifier);

  final titleController = TextEditingController(text: event.name);
  final placesController = TextEditingController(
    text: event.quota?.toString() ?? '',
  );
  final startDateController = TextEditingController(
    text: dateFormatter.format(event.openDatetime),
  );
  final endDateController = TextEditingController(
    text: event.closeDatetime != null
        ? dateFormatter.format(event.closeDatetime!)
        : '',
  );

  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: Builder(
      builder: (modalContext) => BottomModalTemplate(
        title: l10n.ticketsGeneralInfo,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextEntry(
                maxLines: 1,
                label: l10n.ticketsTitleLabel,
                controller: titleController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              TextEntry(
                maxLines: 1,
                label: l10n.ticketsPlacesLabel,
                controller: placesController,
                keyboardType: TextInputType.number,
                isInt: true,
                canBeEmpty: true,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              DateEntry(
                label: l10n.ticketsStartDateLabel,
                controller: startDateController,
                onTap: () => getFullDate(modalContext, startDateController),
              ),
              DateEntry(
                label: l10n.ticketsEndDateLabel,
                controller: endDateController,
                onTap: () => getFullDate(modalContext, endDateController),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.ticketsCloseEventHint,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.onTertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Button(
                text: l10n.ticketsSaveChanges,
                onPressed: () async {
                  if (titleController.text.trim().isEmpty) {
                    displayToast(
                      modalContext,
                      TypeMsg.error,
                      l10n.ticketsTitleRequired,
                    );
                    return;
                  }
                  if (startDateController.text.trim().isEmpty) {
                    displayToast(
                      modalContext,
                      TypeMsg.error,
                      l10n.ticketsStartDateRequired,
                    );
                    return;
                  }

                  Navigator.pop(modalContext);
                  if (!context.mounted) return;

                  try {
                    final openDatetime = DateTime.parse(
                      processDateBackWithHourMaybe(
                        startDateController.text,
                        locale.toString(),
                      ),
                    );
                    DateTime? closeDatetime;
                    if (endDateController.text.trim().isNotEmpty) {
                      closeDatetime = DateTime.parse(
                        processDateBackWithHourMaybe(
                          endDateController.text,
                          locale.toString(),
                        ),
                      );
                    }
                    int? quota;
                    if (placesController.text.trim().isNotEmpty) {
                      quota = int.tryParse(placesController.text.trim());
                    }

                    final updated = event.copyWith(
                      name: titleController.text.trim(),
                      quota: quota,
                      openDatetime: openDatetime,
                      closeDatetime: closeDatetime,
                    );

                    await tokenExpireWrapper(ref, () async {
                      final success = await editNotifier.editTicketEvent(
                        updated,
                      );

                      if (!context.mounted) return;
                      if (success) {
                        displayToast(
                          context,
                          TypeMsg.msg,
                          l10n.ticketsEditSuccess,
                        );
                        onEventUpdated(updated);
                      } else {
                        _showEditError(context, ref, l10n);
                      }
                    });
                  } catch (e) {
                    if (context.mounted) {
                      displayToast(context, TypeMsg.error, e.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  titleController.dispose();
  placesController.dispose();
  startDateController.dispose();
  endDateController.dispose();
}

Future<void> _toggleEventDisabled(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  bool disabled,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final editNotifier = ref.read(ticketEventEditProvider.notifier);
  final updated = event.copyWith(disabled: disabled);
  await tokenExpireWrapper(ref, () async {
    final success = await editNotifier.editTicketEvent(updated);
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      onEventUpdated(updated);
    } else {
      _showEditError(context, ref, l10n);
    }
  });
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
      _showEditError(context, ref, l10n);
    }
  });
}

Future<void> _toggleCategoryDisabled(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Category category,
  bool disabled,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final editNotifier = ref.read(ticketEventEditProvider.notifier);
  await tokenExpireWrapper(ref, () async {
    final success = await editNotifier.updateCategoryDisabled(
      event.id,
      category.id,
      disabled,
    );
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      onEventUpdated(
        _withCategory(event, category.copyWith(disabled: disabled)),
      );
    } else {
      _showEditError(context, ref, l10n);
    }
  });
}

Future<void> _toggleQuestionDisabled(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Question question,
  bool disabled,
  void Function(TicketEvent) onEventUpdated,
) async {
  final l10n = AppLocalizations.of(context)!;
  final editNotifier = ref.read(ticketEventEditProvider.notifier);
  await tokenExpireWrapper(ref, () async {
    final success = await editNotifier.updateQuestionDisabled(
      event.id,
      question.id,
      disabled,
    );
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      onEventUpdated(
        _withQuestion(event, question.copyWith(disabled: disabled)),
      );
    } else {
      _showEditError(context, ref, l10n);
    }
  });
}

class _SessionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  const _SessionsSection({required this.event, required this.onEventUpdated});

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

    return _SectionCard(
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
                    if (locked) const _ReadOnlyBanner(),
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
                              if (!await _showDeleteConfirm(context, ref)) {
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
                                  _showEditError(
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
                      displayToast(
                        context,
                        TypeMsg.msg,
                        l10n.ticketsEditSuccess,
                      );
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
}

class _CategoriesSection extends HookConsumerWidget {
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  const _CategoriesSection({required this.event, required this.onEventUpdated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.watch(ticketEventEditProvider.notifier);

    Future<void> addCategory() async {
      final nameController = TextEditingController();
      final priceController = TextEditingController(text: '0');
      final quotaController = TextEditingController();

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.ticketsAddCategory),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextEntry(
                label: l10n.ticketsTariffLabel(event.categories.length + 1),
                controller: nameController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              TextEntry(
                label: l10n.ticketsPriceLabel,
                controller: priceController,
                keyboardType: TextInputType.number,
                onChanged: (_) {},
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
      if (nameController.text.trim().isEmpty) return;

      final price = int.tryParse(priceController.text) ?? 0;
      if (price != 0 && price < 1) {
        displayToast(context, TypeMsg.error, l10n.ticketsMinPriceError);
        return;
      }

      final category = Category(
        id: '',
        name: nameController.text.trim(),
        price: price,
        quota: quotaController.text.isEmpty
            ? null
            : int.tryParse(quotaController.text),
        requiredMembership: null,
      );

      await tokenExpireWrapper(ref, () async {
        final created = await editNotifier.addCategory(event.id, category);
        if (!context.mounted) return;
        if (created != null) {
          displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
          onEventUpdated(
            event.copyWith(categories: [...event.categories, created]),
          );
        } else {
          displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
        }
      });
    }

    return _SectionCard(
      title: l10n.ticketsCategories,
      child: Column(
        children: [
          ...event.categories.map((category) {
            final locked = category.hasSales;
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
                    if (locked) const _ReadOnlyBanner(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            category.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${category.price}€',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.gradient1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${l10n.ticketsQuotaLabel}: ${category.quota?.toString() ?? l10n.ticketsUnlimited}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    Text(
                      '${category.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${category.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    if (category.disabled)
                      Text(
                        l10n.ticketsDisabled,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    SwitchListTile(
                      value: !category.disabled,
                      onChanged: (value) => _toggleCategoryDisabled(
                        context,
                        ref,
                        event,
                        category,
                        !value,
                        onEventUpdated,
                      ),
                      title: Text(
                        category.disabled
                            ? l10n.ticketsCategoryDeactivated
                            : l10n.ticketsCategoryActivated,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (!locked) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () => _showCategoryEditDialog(
                              context,
                              ref,
                              event,
                              category,
                              onEventUpdated,
                            ),
                            child: Text(l10n.ticketsEdit),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () async {
                              if (!await _showDeleteConfirm(context, ref)) {
                                return;
                              }
                              if (!context.mounted) return;
                              await tokenExpireWrapper(ref, () async {
                                final success = await editNotifier
                                    .deleteCategory(event.id, category.id);
                                if (!context.mounted) return;
                                if (success) {
                                  displayToast(
                                    context,
                                    TypeMsg.msg,
                                    l10n.ticketsEditSuccess,
                                  );
                                  onEventUpdated(
                                    _withoutCategory(event, category.id),
                                  );
                                } else {
                                  _showEditError(
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
            onPressed: addCategory,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddCategory),
          ),
        ],
      ),
    );
  }

  Future<void> _showCategoryEditDialog(
    BuildContext context,
    WidgetRef ref,
    TicketEvent event,
    Category category,
    void Function(TicketEvent) onEventUpdated,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.read(ticketEventEditProvider.notifier);

    final nameController = TextEditingController(text: category.name);
    final priceController = TextEditingController(
      text: category.price.toString(),
    );
    final quotaController = TextEditingController(
      text: category.quota?.toString() ?? '',
    );
    var disabled = category.disabled;

    await showCustomBottomModal(
      context: context,
      ref: ref,
      modal: StatefulBuilder(
        builder: (modalContext, setState) => BottomModalTemplate(
          title: l10n.ticketsEdit,
          child: Column(
            children: [
              TextEntry(
                label: l10n.ticketsCategoryLabel,
                controller: nameController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              TextEntry(
                label: l10n.ticketsPriceLabel,
                controller: priceController,
                keyboardType: TextInputType.number,
                onChanged: (_) {},
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
                      ? l10n.ticketsCategoryDeactivated
                      : l10n.ticketsCategoryActivated,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              Button(
                text: l10n.ticketsSaveChanges,
                onPressed: () async {
                  Navigator.pop(modalContext);
                  if (!context.mounted) return;

                  final price =
                      int.tryParse(priceController.text) ?? category.price;
                  if (price != 0 && price < 1) {
                    displayToast(
                      context,
                      TypeMsg.error,
                      l10n.ticketsMinPriceError,
                    );
                    return;
                  }

                  final updated = category.copyWith(
                    name: nameController.text.trim(),
                    price: price,
                    quota: quotaController.text.isEmpty
                        ? null
                        : int.tryParse(quotaController.text),
                    disabled: disabled,
                  );

                  await tokenExpireWrapper(ref, () async {
                    final success = await editNotifier.updateCategory(
                      event.id,
                      updated,
                    );
                    if (!context.mounted) return;
                    if (success) {
                      displayToast(
                        context,
                        TypeMsg.msg,
                        l10n.ticketsEditSuccess,
                      );
                      onEventUpdated(_withCategory(event, updated));
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
    priceController.dispose();
    quotaController.dispose();
  }
}

class _QuestionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  const _QuestionsSection({required this.event, required this.onEventUpdated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.watch(ticketEventEditProvider.notifier);

    Future<void> addQuestion() async {
      final textController = TextEditingController();
      final priceController = TextEditingController();
      var answerType = AnswerType.text;
      var required = false;

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: Text(l10n.ticketsAddQuestion),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextEntry(
                    label: l10n.ticketsQuestionLabel(
                      event.questions.length + 1,
                    ),
                    controller: textController,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<AnswerType>(
                    initialValue: answerType,
                    decoration: InputDecoration(
                      labelText: l10n.ticketsQuestionTypeLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: AnswerType.text,
                        child: Text(l10n.ticketsAnswerTypeText),
                      ),
                      DropdownMenuItem(
                        value: AnswerType.number,
                        child: Text(l10n.ticketsAnswerTypeNumber),
                      ),
                      DropdownMenuItem(
                        value: AnswerType.boolean,
                        child: Text(l10n.ticketsAnswerTypeBoolean),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => answerType = value);
                    },
                  ),
                  const SizedBox(height: 8),
                  TextEntry(
                    label: l10n.ticketsPriceLabel,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    canBeEmpty: true,
                    onChanged: (_) {},
                  ),
                  CheckboxListTile(
                    value: required,
                    onChanged: (value) =>
                        setState(() => required = value ?? false),
                    title: Text(l10n.ticketsQuestionRequiredLabel),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
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
        ),
      );

      if (confirmed != true || !context.mounted) return;
      if (textController.text.trim().isEmpty) return;

      final price = priceController.text.isEmpty
          ? null
          : int.tryParse(priceController.text);

      await tokenExpireWrapper(ref, () async {
        final created = await editNotifier.createQuestion(
          event.id,
          questionText: textController.text.trim(),
          answerType: answerType,
          required: required,
          price: price,
        );

        if (!context.mounted) return;
        if (created != null) {
          displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
          onEventUpdated(
            event.copyWith(questions: [...event.questions, created]),
          );
        } else {
          _showEditError(context, ref, l10n);
        }
      });
    }

    return _SectionCard(
      title: l10n.ticketsQuestions,
      child: Column(
        children: [
          if (event.questions.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '-',
                style: TextStyle(color: ColorConstants.tertiary),
              ),
            ),
          ...event.questions.map((question) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              color: question.disabled ? Colors.grey.shade100 : null,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            question.question,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (question.disabled)
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
                      '${l10n.ticketsQuestionTypeLabel}: ${question.answerType.value}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    if (question.price != null)
                      Text(
                        '${l10n.ticketsPriceLabel}: ${question.price}€',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.onTertiary,
                        ),
                      ),
                    SwitchListTile(
                      value: !question.disabled,
                      onChanged: (value) => _toggleQuestionDisabled(
                        context,
                        ref,
                        event,
                        question,
                        !value,
                        onEventUpdated,
                      ),
                      title: Text(
                        question.disabled
                            ? l10n.ticketsQuestionDeactivated
                            : l10n.ticketsQuestionActivated,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => _showQuestionEditDialog(
                            context,
                            ref,
                            event,
                            question,
                            onEventUpdated,
                          ),
                          child: Text(l10n.ticketsEdit),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () async {
                            if (!await _showDeleteConfirm(context, ref)) return;
                            if (!context.mounted) return;
                            await tokenExpireWrapper(ref, () async {
                              final success = await editNotifier.deleteQuestion(
                                event.id,
                                question.id,
                              );
                              if (!context.mounted) return;
                              if (success) {
                                displayToast(
                                  context,
                                  TypeMsg.msg,
                                  l10n.ticketsEditSuccess,
                                );
                                onEventUpdated(
                                  _withoutQuestion(event, question.id),
                                );
                              } else {
                                _showEditError(
                                  context,
                                  ref,
                                  l10n,
                                  fallbackDueAnswers:
                                      l10n.ticketsCannotDeleteDueAnswers,
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
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: addQuestion,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddQuestion),
          ),
        ],
      ),
    );
  }

  Future<void> _showQuestionEditDialog(
    BuildContext context,
    WidgetRef ref,
    TicketEvent event,
    Question question,
    void Function(TicketEvent) onEventUpdated,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.read(ticketEventEditProvider.notifier);

    final textController = TextEditingController(text: question.question);
    final priceController = TextEditingController(
      text: question.price?.toString() ?? '',
    );
    var answerType = question.answerType;
    var required = question.required;
    var disabled = question.disabled;

    await showCustomBottomModal(
      context: context,
      ref: ref,
      modal: StatefulBuilder(
        builder: (modalContext, setState) => BottomModalTemplate(
          title: l10n.ticketsEditTitle,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextEntry(
                  label: l10n.ticketsQuestionLabel(1),
                  controller: textController,
                  onChanged: (_) {},
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<AnswerType>(
                  initialValue: answerType,
                  decoration: InputDecoration(
                    labelText: l10n.ticketsQuestionTypeLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: AnswerType.text,
                      child: Text(l10n.ticketsAnswerTypeText),
                    ),
                    DropdownMenuItem(
                      value: AnswerType.number,
                      child: Text(l10n.ticketsAnswerTypeNumber),
                    ),
                    DropdownMenuItem(
                      value: AnswerType.boolean,
                      child: Text(l10n.ticketsAnswerTypeBoolean),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => answerType = v);
                  },
                ),
                const SizedBox(height: 8),
                TextEntry(
                  label: l10n.ticketsPriceLabel,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  canBeEmpty: true,
                  onChanged: (_) {},
                ),
                CheckboxListTile(
                  value: required,
                  onChanged: (v) => setState(() => required = v ?? false),
                  title: Text(l10n.ticketsQuestionRequiredLabel),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: !disabled,
                  onChanged: (v) => setState(() => disabled = !v),
                  title: Text(
                    disabled
                        ? l10n.ticketsQuestionDeactivated
                        : l10n.ticketsQuestionActivated,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
                Button(
                  text: l10n.ticketsSaveChanges,
                  onPressed: () async {
                    Navigator.pop(modalContext);
                    if (!context.mounted) return;

                    final price = priceController.text.isEmpty
                        ? null
                        : int.tryParse(priceController.text);

                    final updatedQuestion = question.copyWith(
                      question: textController.text.trim(),
                      answerType: answerType,
                      required: required,
                      price: price,
                      disabled: disabled,
                    );

                    await tokenExpireWrapper(ref, () async {
                      final success = await editNotifier.updateQuestion(
                        event.id,
                        question.id,
                        questionText: updatedQuestion.question,
                        answerType: updatedQuestion.answerType,
                        required: updatedQuestion.required,
                        price: updatedQuestion.price,
                        disabled: updatedQuestion.disabled,
                      );

                      if (!context.mounted) return;
                      if (success) {
                        displayToast(
                          context,
                          TypeMsg.msg,
                          l10n.ticketsEditSuccess,
                        );
                        onEventUpdated(_withQuestion(event, updatedQuestion));
                      } else {
                        _showEditError(context, ref, l10n);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    textController.dispose();
    priceController.dispose();
  }
}
