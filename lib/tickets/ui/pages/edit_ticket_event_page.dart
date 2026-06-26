import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tickets/adapters/category.dart';
import 'package:titan/tickets/adapters/ticket_event.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/providers/ticket_event_list_provider.dart';
import 'package:titan/tickets/providers/ticket_event_provider.dart';
import 'package:titan/tickets/ui/components/edit_ticket_event_helpers.dart';
import 'package:titan/tickets/ui/components/read_only_banner.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

// Prices are stored in cents by the backend and shown in euros everywhere in
// the module.
const _centsPerEuro = 100;

class EditTicketEventPage extends HookConsumerWidget {
  const EditTicketEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedTicketEventIdProvider);
    final ticketEventNotifier = ref.watch(ticketEventProvider.notifier);

    useEffect(() {
      if (selectedId != null) {
        ticketEventNotifier.loadTicketEvent(selectedId);
      }
      return null;
    }, [selectedId]);

    if (selectedId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => QR.back());
      return const SizedBox.shrink();
    }

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(
          context,
        ).colorScheme.copyWith(primary: ColorConstants.main),
      ),
      child: ref
          .watch(ticketEventProvider)
          .when(
            data: (ticketEvent) =>
                _EditTicketEventForm(ticketEvent: ticketEvent),
            loading: () => const TicketTemplate(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => TicketTemplate(
              child: Center(
                child: Text(
                  e.toString(),
                  style: const TextStyle(color: ColorConstants.error),
                ),
              ),
            ),
          ),
    );
  }
}

class _EditTicketEventForm extends HookConsumerWidget {
  final EventAdmin ticketEvent;

  const _EditTicketEventForm({required this.ticketEvent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ticketEventNotifier = ref.watch(ticketEventProvider.notifier);
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());

    // Once tickets are sold or held in a checkout the event can no longer be
    // deleted, and its questions are frozen because answers already exist.
    final soldOrPending =
        ticketEvent.ticketsSold + ticketEvent.ticketsInCheckout;
    final canDeleteEvent = soldOrPending == 0;

    // Controllers pour les champs principaux
    final titleController = useTextEditingController(text: ticketEvent.name);
    final placesController = useTextEditingController(
      text: ticketEvent.quota?.toString() ?? '',
    );
    final startDateController = useTextEditingController(
      text: dateFormatter.format(ticketEvent.openDatetime),
    );
    final endDateController = useTextEditingController(
      text: ticketEvent.closeDatetime != null
          ? dateFormatter.format(ticketEvent.closeDatetime!)
          : '',
    );

    // Field edits are staged here and written back by the save button, unlike
    // adding and removing an item which the backend has to arbitrate straight
    // away.
    final categories = useState<List<CategoryAdmin>>(ticketEvent.categories);
    final sessions = useState<List<SessionAdmin>>(ticketEvent.sessions);
    final questions = useState<List<QuestionAdmin>>(ticketEvent.questions);

    final disabled = useState(ticketEvent.disabled);

    // An add or a delete reshapes the event under us, so the staged copies and
    // the row controllers are re-seeded from the server whenever the set of
    // ids changes. Pending edits to the other rows are dropped with them.
    final categoryIds = ticketEvent.categories.map((c) => c.id).join(',');
    final sessionIds = ticketEvent.sessions.map((s) => s.id).join(',');
    final questionIds = ticketEvent.questions.map((q) => q.id).join(',');
    useEffect(() {
      categories.value = ticketEvent.categories;
      return null;
    }, [categoryIds]);
    useEffect(() {
      sessions.value = ticketEvent.sessions;
      return null;
    }, [sessionIds]);
    useEffect(() {
      questions.value = ticketEvent.questions;
      return null;
    }, [questionIds]);

    /// The event as the provider currently holds it. Each save step merges into
    /// the previous one, so the stale [ticketEvent] must not be reused.
    EventAdmin? latestEvent() => ref.read(ticketEventProvider).asData?.value;

    Future<void> save() async {
      if (titleController.text.trim().isEmpty) {
        displayToast(context, TypeMsg.error, l10n.ticketsTitleRequired);
        return;
      }
      if (startDateController.text.trim().isEmpty) {
        displayToast(context, TypeMsg.error, l10n.ticketsStartDateRequired);
        return;
      }

      final DateTime openDatetime;
      DateTime? closeDatetime;
      final int quota;
      try {
        openDatetime = DateTime.parse(
          processDateBackWithHourMaybe(
            startDateController.text,
            locale.toString(),
          ),
        );
        if (endDateController.text.trim().isNotEmpty) {
          closeDatetime = DateTime.parse(
            processDateBackWithHourMaybe(
              endDateController.text,
              locale.toString(),
            ),
          );
        }
        quota = placesController.text.trim().isEmpty
            ? 0
            : int.parse(placesController.text);
      } catch (e) {
        displayToast(context, TypeMsg.error, "${l10n.othersError}: $e");
        return;
      }

      final success = await ticketEventNotifier.editTicketEvent(
        ticketEvent.copyWith(
          name: titleController.text.trim(),
          quota: quota,
          openDatetime: openDatetime,
          closeDatetime: closeDatetime,
          disabled: disabled.value,
        ),
      );
      if (!context.mounted) return;
      if (!success) {
        showEditError(context, l10n);
        return;
      }

      for (final category in categories.value) {
        final original = ticketEvent.categories.firstWhereOrNull(
          (c) => c.id == category.id,
        );
        if (original == null || original == category) continue;
        final event = latestEvent();
        if (event == null) break;
        final ok = await ticketEventNotifier.updateCategory(event, category);
        if (!context.mounted) return;
        if (!ok) {
          showEditError(context, l10n);
          return;
        }
      }

      for (final session in sessions.value) {
        final original = ticketEvent.sessions.firstWhereOrNull(
          (s) => s.id == session.id,
        );
        if (original == null || original == session) continue;
        final event = latestEvent();
        if (event == null) break;
        final ok = await ticketEventNotifier.updateSession(event, session);
        if (!context.mounted) return;
        if (!ok) {
          showEditError(context, l10n);
          return;
        }
      }

      for (final question in questions.value) {
        final original = ticketEvent.questions.firstWhereOrNull(
          (q) => q.id == question.id,
        );
        if (original == null || original == question) continue;
        final event = latestEvent();
        if (event == null) break;
        final ok = await ticketEventNotifier.updateQuestion(event, question);
        if (!context.mounted) return;
        if (!ok) {
          showEditError(context, l10n, reason: l10n.ticketsReadOnlyDueAnswers);
          return;
        }
      }

      if (!context.mounted) return;
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      await ref.read(ticketEventListProvider.notifier).loadShotgunList();
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }

    Future<void> deleteEvent() async {
      if (!await showDeleteConfirm(context, ref)) return;
      if (!context.mounted) return;

      // A successful delete leaves the provider with nothing to show, which
      // unmounts this form, so the way out has to be captured beforehand.
      final navigator = Navigator.of(context);
      final navigatorContext = navigator.context;

      final success = await ticketEventNotifier.deleteEvent(ticketEvent.id);

      if (!success) {
        if (!context.mounted) return;
        showEditError(context, l10n, reason: l10n.ticketsCannotDeleteDueSales);
        return;
      }

      await ref.read(ticketEventListProvider.notifier).loadShotgunList();
      if (!navigatorContext.mounted) return;
      displayToast(
        navigatorContext,
        TypeMsg.msg,
        l10n.ticketsDeleteEventSuccess,
      );
      navigator.pop();
    }

    final scrollController = useScrollController();

    return TicketTemplate(
      child: ScrollToHideNavbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                l10n.ticketsEditTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TicketEventStatusChip(status: ticketEvent.status),
              ),
              const SizedBox(height: 8),
              Text(
                '${l10n.ticketsGlobalStats}: ${ticketEvent.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${ticketEvent.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorConstants.onTertiary,
                ),
              ),
              const SizedBox(height: 24),
              TextEntry(
                maxLines: 1,
                label: l10n.ticketsTitleLabel,
                controller: titleController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              TextEntry(
                maxLines: 1,
                label: l10n.ticketsPlacesLabel,
                controller: placesController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),
              DateEntry(
                label: l10n.ticketsStartDateLabel,
                controller: startDateController,
                onTap: () => getFullDate(context, startDateController),
              ),
              DateEntry(
                label: l10n.ticketsEndDateLabel,
                controller: endDateController,
                onTap: () => getFullDate(context, endDateController),
              ),
              SwitchListTile(
                value: !disabled.value,
                onChanged: (value) => disabled.value = !value,
                title: Text(
                  disabled.value
                      ? l10n.ticketsEventDeactivated
                      : l10n.ticketsEventActivated,
                ),
                subtitle: Text(l10n.ticketsCloseEventHint),
                contentPadding: EdgeInsets.zero,
                activeThumbColor: ColorConstants.main,
              ),
              const SizedBox(height: 16),
              _EditCategoriesSection(
                key: ValueKey('categories:$categoryIds'),
                event: ticketEvent,
                categories: categories.value,
                onChanged: (value) => categories.value = value,
              ),
              const SizedBox(height: 16),
              _EditSessionsSection(
                key: ValueKey('sessions:$sessionIds'),
                event: ticketEvent,
                sessions: sessions.value,
                onChanged: (value) => sessions.value = value,
              ),
              const SizedBox(height: 16),
              _EditQuestionsSection(
                key: ValueKey('questions:$questionIds'),
                event: ticketEvent,
                questions: questions.value,
                locked: !canDeleteEvent,
                onChanged: (value) => questions.value = value,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(
                    backgroundColor: ColorConstants.main,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(l10n.ticketsSaveChanges),
                ),
              ),
              const SizedBox(height: 24),
              if (!canDeleteEvent)
                ReadOnlyBanner(message: l10n.ticketsCannotDeleteDueSales),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: canDeleteEvent ? deleteEvent : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorConstants.error,
                    side: const BorderSide(color: ColorConstants.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(l10n.ticketsDeleteEvent),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Edit Categories Section ──────────────────────────────────────────────────

class _EditCategoriesSection extends ConsumerWidget {
  final EventAdmin event;
  final List<CategoryAdmin> categories;
  final ValueChanged<List<CategoryAdmin>> onChanged;

  const _EditCategoriesSection({
    super.key,
    required this.event,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ticketEventNotifier = ref.watch(ticketEventProvider.notifier);

    Future<void> addCategory() async {
      final result = await showDialog<_CategoryFormResult>(
        context: context,
        builder: (_) => _AddCategoryDialog(tariffIndex: categories.length + 1),
      );
      if (result == null || result.name.isEmpty || !context.mounted) return;

      final priceInEuros = int.tryParse(result.priceText) ?? 0;
      if (priceInEuros < 0) {
        displayToast(context, TypeMsg.error, l10n.ticketsMinPriceError);
        return;
      }

      final created = await ticketEventNotifier.createCategory(
        event,
        CategoryCreate(
          name: result.name,
          price: priceInEuros * _centsPerEuro,
          quota: int.tryParse(result.quotaText),
          requiredMembership: null,
        ),
      );
      if (!context.mounted) return;
      if (created == null) {
        showEditError(context, l10n);
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    Future<void> deleteCategory(CategoryAdmin category) async {
      if (!await showDeleteConfirm(context, ref)) return;
      if (!context.mounted) return;

      final success = await ticketEventNotifier.deleteCategory(
        event,
        category.id,
      );
      if (!context.mounted) return;
      if (!success) {
        showEditError(context, l10n, reason: l10n.ticketsCannotDeleteDueSales);
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    return SectionCard(
      title: l10n.ticketsTariffs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (index, category) in categories.indexed)
            _CategoryRow(
              key: ValueKey(category.id),
              index: index,
              category: category,
              onChanged: (updated) => onChanged([
                for (final c in categories) c.id == updated.id ? updated : c,
              ]),
              onDelete: () => deleteCategory(category),
            ),
          OutlinedButton.icon(
            onPressed: addCategory,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddCategory),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorConstants.main,
              side: const BorderSide(color: ColorConstants.main),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends HookWidget {
  final int index;
  final CategoryAdmin category;
  final ValueChanged<CategoryAdmin> onChanged;
  final VoidCallback onDelete;

  const _CategoryRow({
    super.key,
    required this.index,
    required this.category,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // A tariff that has already been bought into can no longer be renamed,
    // repriced or removed.
    final locked = category.ticketsSold + category.ticketsInCheckout > 0;
    final nameController = useTextEditingController(text: category.name);
    final priceController = useTextEditingController(
      text: category.priceInEuros.toString(),
    );
    final quotaController = useTextEditingController(
      text: category.quota?.toString() ?? '',
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (locked) ...[const ReadOnlyBanner(), const SizedBox(height: 8)],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextEntry(
                  label: l10n.ticketsTariffLabel(index + 1),
                  controller: nameController,
                  enabled: !locked,
                  onChanged: (value) =>
                      onChanged(category.copyWith(name: value)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: TextEntry(
                  label: l10n.ticketsPriceLabel,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  enabled: !locked,
                  onChanged: (value) {
                    final euros = int.tryParse(value) ?? category.priceInEuros;
                    onChanged(category.copyWith(price: euros * _centsPerEuro));
                  },
                ),
              ),
              if (!locked)
                IconButton(
                  onPressed: onDelete,
                  icon: const HeroIcon(
                    HeroIcons.minusCircle,
                    size: 22,
                    color: ColorConstants.error,
                  ),
                  tooltip: l10n.ticketsDeleteCategory,
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextEntry(
            label: l10n.ticketsQuotaLabel,
            controller: quotaController,
            keyboardType: TextInputType.number,
            canBeEmpty: true,
            enabled: !locked,
            onChanged: (value) => onChanged(
              category.copyWith(
                quota: value.isEmpty ? null : int.tryParse(value),
              ),
            ),
          ),
          SwitchListTile(
            value: !category.disabled,
            onChanged: (value) =>
                onChanged(category.copyWith(disabled: !value)),
            title: Text(
              category.disabled
                  ? l10n.ticketsCategoryDeactivated
                  : l10n.ticketsCategoryActivated,
            ),
            contentPadding: EdgeInsets.zero,
            activeThumbColor: ColorConstants.main,
          ),
          Text(
            '${category.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${category.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
            style: const TextStyle(
              fontSize: 11,
              color: ColorConstants.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFormResult {
  const _CategoryFormResult({
    required this.name,
    required this.priceText,
    required this.quotaText,
  });

  final String name;
  final String priceText;
  final String quotaText;
}

class _AddCategoryDialog extends HookWidget {
  const _AddCategoryDialog({required this.tariffIndex});

  final int tariffIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController();
    final priceController = useTextEditingController(text: '0');
    final quotaController = useTextEditingController();

    return AlertDialog(
      title: Text(l10n.ticketsAddCategory),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextEntry(
              label: l10n.ticketsTariffLabel(tariffIndex),
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.globalCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            _CategoryFormResult(
              name: nameController.text.trim(),
              priceText: priceController.text,
              quotaText: quotaController.text,
            ),
          ),
          child: Text(l10n.ticketsAddCategory),
        ),
      ],
    );
  }
}

// ── Edit Sessions Section ────────────────────────────────────────────────────

class _EditSessionsSection extends ConsumerWidget {
  final EventAdmin event;
  final List<SessionAdmin> sessions;
  final ValueChanged<List<SessionAdmin>> onChanged;

  const _EditSessionsSection({
    super.key,
    required this.event,
    required this.sessions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final ticketEventNotifier = ref.watch(ticketEventProvider.notifier);

    Future<void> addSession() async {
      final result = await showDialog<_SessionFormResult>(
        context: context,
        builder: (_) => _AddSessionDialog(sessionIndex: sessions.length + 1),
      );
      if (result == null || !context.mounted) return;
      if (result.name.isEmpty || result.dateText.isEmpty) return;

      final DateTime startDatetime;
      try {
        startDatetime = DateTime.parse(
          processDateBackWithHourMaybe(result.dateText, locale.toString()),
        );
      } catch (e) {
        displayToast(context, TypeMsg.error, "${l10n.othersError}: $e");
        return;
      }

      final created = await ticketEventNotifier.createSession(
        event,
        SessionCreate(
          name: result.name,
          startDatetime: startDatetime,
          quota: int.tryParse(result.quotaText),
        ),
      );
      if (!context.mounted) return;
      if (created == null) {
        showEditError(context, l10n);
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    Future<void> deleteSession(SessionAdmin session) async {
      if (!await showDeleteConfirm(context, ref)) return;
      if (!context.mounted) return;

      final success = await ticketEventNotifier.deleteSession(
        event,
        session.id,
      );
      if (!context.mounted) return;
      if (!success) {
        showEditError(context, l10n, reason: l10n.ticketsCannotDeleteDueSales);
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    return SectionCard(
      title: l10n.ticketsSessions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (index, session) in sessions.indexed)
            _SessionRow(
              key: ValueKey(session.id),
              index: index,
              session: session,
              onChanged: (updated) => onChanged([
                for (final s in sessions) s.id == updated.id ? updated : s,
              ]),
              onDelete: () => deleteSession(session),
            ),
          OutlinedButton.icon(
            onPressed: addSession,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddSession),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorConstants.main,
              side: const BorderSide(color: ColorConstants.main),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionRow extends HookWidget {
  final int index;
  final SessionAdmin session;
  final ValueChanged<SessionAdmin> onChanged;
  final VoidCallback onDelete;

  const _SessionRow({
    super.key,
    required this.index,
    required this.session,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
    // A session that has already been bought into can no longer be renamed,
    // rescheduled or removed.
    final locked = session.ticketsSold + session.ticketsInCheckout > 0;
    final nameController = useTextEditingController(text: session.name);
    final dateController = useTextEditingController(
      text: dateFormatter.format(session.startDatetime),
    );
    final quotaController = useTextEditingController(
      text: session.quota?.toString() ?? '',
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (locked) ...[const ReadOnlyBanner(), const SizedBox(height: 8)],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextEntry(
                  label: l10n.ticketsSessionLabelNumbered(index + 1),
                  controller: nameController,
                  enabled: !locked,
                  onChanged: (value) =>
                      onChanged(session.copyWith(name: value)),
                ),
              ),
              if (!locked)
                IconButton(
                  onPressed: onDelete,
                  icon: const HeroIcon(
                    HeroIcons.minusCircle,
                    size: 22,
                    color: ColorConstants.error,
                  ),
                  tooltip: l10n.ticketsDeleteSession,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DateEntry(
                  label: l10n.ticketsDateLabel,
                  controller: dateController,
                  enabled: !locked,
                  // DateEntry taps still fire when the inner field is
                  // disabled, so the picker has to be held back explicitly.
                  onTap: locked
                      ? () {}
                      : () async {
                          await getFullDate(context, dateController);
                          if (dateController.text.isEmpty) return;
                          onChanged(
                            session.copyWith(
                              startDatetime: DateTime.parse(
                                processDateBackWithHourMaybe(
                                  dateController.text,
                                  locale.toString(),
                                ),
                              ),
                            ),
                          );
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
                  canBeEmpty: true,
                  enabled: !locked,
                  onChanged: (value) => onChanged(
                    session.copyWith(
                      quota: value.isEmpty ? null : int.tryParse(value),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SwitchListTile(
            value: !session.disabled,
            onChanged: (value) => onChanged(session.copyWith(disabled: !value)),
            title: Text(
              session.disabled
                  ? l10n.ticketsSessionDeactivated
                  : l10n.ticketsSessionActivated,
            ),
            contentPadding: EdgeInsets.zero,
            activeThumbColor: ColorConstants.main,
          ),
          Text(
            '${session.ticketsSold} ${l10n.ticketsTicketsSold.toLowerCase()}, ${session.ticketsInCheckout} ${l10n.ticketsTicketsInCheckout.toLowerCase()}',
            style: const TextStyle(
              fontSize: 11,
              color: ColorConstants.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
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

class _AddSessionDialog extends HookWidget {
  const _AddSessionDialog({required this.sessionIndex});

  final int sessionIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController();
    final dateController = useTextEditingController();
    final quotaController = useTextEditingController();

    return AlertDialog(
      title: Text(l10n.ticketsAddSession),
      content: SingleChildScrollView(
        child: Column(
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
          child: Text(l10n.ticketsAddSession),
        ),
      ],
    );
  }
}

// ── Edit Questions Section ──────────────────────────────────────────────────

class _EditQuestionsSection extends ConsumerWidget {
  final EventAdmin event;
  final List<QuestionAdmin> questions;
  final ValueChanged<List<QuestionAdmin>> onChanged;

  /// Questions are frozen once attendees have answered them.
  final bool locked;

  const _EditQuestionsSection({
    super.key,
    required this.event,
    required this.questions,
    required this.onChanged,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ticketEventNotifier = ref.watch(ticketEventProvider.notifier);

    Future<void> addQuestion() async {
      final result = await showDialog<_QuestionFormResult>(
        context: context,
        builder: (_) => _AddQuestionDialog(questionIndex: questions.length + 1),
      );
      if (result == null || result.text.isEmpty || !context.mounted) return;

      final priceInEuros = int.tryParse(result.priceText);
      final created = await ticketEventNotifier.createQuestion(
        event,
        QuestionCreate(
          question: result.text,
          answerType: result.answerType,
          price: priceInEuros == null ? null : priceInEuros * _centsPerEuro,
          required: result.required,
        ),
      );
      if (!context.mounted) return;
      if (created == null) {
        showEditError(context, l10n);
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    Future<void> deleteQuestion(QuestionAdmin question) async {
      if (!await showDeleteConfirm(context, ref)) return;
      if (!context.mounted) return;

      final success = await ticketEventNotifier.deleteQuestion(
        event,
        question.id,
      );
      if (!context.mounted) return;
      if (!success) {
        showEditError(
          context,
          l10n,
          reason: l10n.ticketsCannotDeleteDueAnswers,
        );
        return;
      }
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
    }

    return SectionCard(
      title: l10n.ticketsQuestions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (locked) ...[
            ReadOnlyBanner(message: l10n.ticketsReadOnlyDueAnswers),
            const SizedBox(height: 16),
          ],
          for (final (index, question) in questions.indexed)
            _QuestionRow(
              key: ValueKey(question.id),
              index: index,
              question: question,
              locked: locked,
              onChanged: (updated) => onChanged([
                for (final q in questions) q.id == updated.id ? updated : q,
              ]),
              onDelete: () => deleteQuestion(question),
            ),
          if (!locked)
            OutlinedButton.icon(
              onPressed: addQuestion,
              icon: const HeroIcon(HeroIcons.plus, size: 20),
              label: Text(l10n.ticketsAddQuestion),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorConstants.main,
                side: const BorderSide(color: ColorConstants.main),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuestionRow extends HookWidget {
  final int index;
  final QuestionAdmin question;
  final bool locked;
  final ValueChanged<QuestionAdmin> onChanged;
  final VoidCallback onDelete;

  const _QuestionRow({
    super.key,
    required this.index,
    required this.question,
    required this.locked,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textController = useTextEditingController(text: question.question);
    final priceController = useTextEditingController(
      text: question.price == null
          ? ''
          : (question.price! ~/ _centsPerEuro).toString(),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextEntry(
                      maxLines: 1,
                      label: l10n.ticketsQuestionLabel(index + 1),
                      controller: textController,
                      enabled: !locked,
                      onChanged: (value) =>
                          onChanged(question.copyWith(question: value)),
                    ),
                  ),
                  if (!locked)
                    IconButton(
                      onPressed: onDelete,
                      icon: const HeroIcon(
                        HeroIcons.minusCircle,
                        size: 22,
                        color: ColorConstants.error,
                      ),
                      tooltip: l10n.ticketsDeleteQuestionTooltip,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<AnswerType>(
                      initialValue: question.answerType,
                      decoration: InputDecoration(
                        labelText: l10n.ticketsQuestionTypeLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _answerTypeItems(l10n),
                      onChanged: locked
                          ? null
                          : (value) {
                              if (value != null) {
                                onChanged(question.copyWith(answerType: value));
                              }
                            },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextEntry(
                      label: l10n.ticketsPriceLabel,
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      canBeEmpty: true,
                      enabled: !locked,
                      onChanged: (value) {
                        final euros = int.tryParse(value);
                        onChanged(
                          question.copyWith(
                            price: euros == null ? null : euros * _centsPerEuro,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: question.required,
                    onChanged: locked
                        ? null
                        : (value) => onChanged(
                            question.copyWith(required: value ?? false),
                          ),
                    activeColor: ColorConstants.main,
                  ),
                  Text(l10n.ticketsQuestionRequiredLabel),
                ],
              ),
              SwitchListTile(
                value: !question.disabled,
                onChanged: locked
                    ? null
                    : (value) => onChanged(question.copyWith(disabled: !value)),
                title: Text(
                  question.disabled
                      ? l10n.ticketsQuestionDeactivated
                      : l10n.ticketsQuestionActivated,
                ),
                contentPadding: EdgeInsets.zero,
                activeThumbColor: ColorConstants.main,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<AnswerType>> _answerTypeItems(AppLocalizations l10n) => [
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
];

class _QuestionFormResult {
  const _QuestionFormResult({
    required this.text,
    required this.answerType,
    required this.required,
    required this.priceText,
  });

  final String text;
  final AnswerType answerType;
  final bool required;
  final String priceText;
}

class _AddQuestionDialog extends HookWidget {
  const _AddQuestionDialog({required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textController = useTextEditingController();
    final priceController = useTextEditingController();
    final answerType = useState(AnswerType.text);
    final required = useState(false);

    return AlertDialog(
      title: Text(l10n.ticketsAddQuestion),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextEntry(
              label: l10n.ticketsQuestionLabel(questionIndex),
              controller: textController,
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<AnswerType>(
              initialValue: answerType.value,
              decoration: InputDecoration(
                labelText: l10n.ticketsQuestionTypeLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _answerTypeItems(l10n),
              onChanged: (value) {
                if (value != null) answerType.value = value;
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
              value: required.value,
              onChanged: (value) => required.value = value ?? false,
              title: Text(l10n.ticketsQuestionRequiredLabel),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.globalCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            _QuestionFormResult(
              text: textController.text.trim(),
              answerType: answerType.value,
              required: required.value,
              priceText: priceController.text,
            ),
          ),
          child: Text(l10n.ticketsAddQuestion),
        ),
      ],
    );
  }
}
