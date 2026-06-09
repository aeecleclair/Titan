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
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tickets/providers/ticket_event_provider.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
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

    final titleController = useTextEditingController(text: event.name);
    final placesController = useTextEditingController(
      text: event.quota?.toString() ?? '',
    );
    final startDateController = useTextEditingController(
      text: dateFormatter.format(event.openDatetime),
    );
    final endDateController = useTextEditingController(
      text: event.closeDatetime != null
          ? dateFormatter.format(event.closeDatetime!)
          : '',
    );

    Future<void> reloadEvent() async {
      ref.invalidate(ticketEventByIdProvider(event.id));
      await ref.read(ticketEventByIdProvider(event.id).notifier).load();
    }

    Future<void> saveGeneralInfo() async {
      if (titleController.text.trim().isEmpty) {
        displayToast(context, TypeMsg.error, l10n.ticketsTitleRequired);
        return;
      }
      if (startDateController.text.trim().isEmpty) {
        displayToast(context, TypeMsg.error, l10n.ticketsStartDateRequired);
        return;
      }

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
          quota = int.parse(placesController.text);
        }

        final success = await editNotifier.editTicketEvent(
          event.copyWith(
            name: titleController.text.trim(),
            quota: quota,
            openDatetime: openDatetime,
            closeDatetime: closeDatetime,
          ),
        );

        if (!context.mounted) return;
        if (success) {
          displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
          await reloadEvent();
        } else {
          displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
        }
      } catch (e) {
        if (context.mounted) {
          displayToast(context, TypeMsg.error, e.toString());
        }
      }
    }

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
                children: [
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
                    keyboardType: TextInputType.number,
                    isInt: true,
                    canBeEmpty: true,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 8),
                  Text(
                    l10n.ticketsCloseEventHint,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.onTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: saveGeneralInfo,
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorConstants.main,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(l10n.ticketsSaveChanges),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SessionsSection(event: event, onUpdated: reloadEvent),
            const SizedBox(height: 16),
            _CategoriesSection(event: event, onUpdated: reloadEvent),
            const SizedBox(height: 16),
            _QuestionsSection(event: event, onUpdated: reloadEvent),
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

class _SessionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final Future<void> Function() onUpdated;

  const _SessionsSection({required this.event, required this.onUpdated});

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

      final created = await editNotifier.addSession(event.id, session);
      if (!context.mounted) return;
      if (created != null) {
        displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
        await onUpdated();
      } else {
        displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
      }
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
                    if (!locked) ...[
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => _showSessionEditDialog(
                          context,
                          ref,
                          event.id,
                          session,
                          onUpdated,
                        ),
                        child: Text(l10n.ticketsEditSession),
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
    String eventId,
    Session session,
    Future<void> Function() onUpdated,
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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.ticketsEditSession),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
              CheckboxListTile(
                value: disabled,
                onChanged: (v) => setState(() => disabled = v ?? false),
                title: Text(l10n.ticketsDisableSession),
                contentPadding: EdgeInsets.zero,
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
              child: Text(l10n.ticketsSaveChanges),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final updated = session.copyWith(
      name: nameController.text.trim(),
      startDatetime: DateTime.parse(
        processDateBackWithHourMaybe(dateController.text, locale.toString()),
      ),
      quota: quotaController.text.isEmpty
          ? null
          : int.tryParse(quotaController.text),
      disabled: disabled,
    );

    final success = await editNotifier.updateSession(eventId, updated);
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      await onUpdated();
    } else {
      final error = ref.read(ticketEventEditProvider).error;
      displayToast(
        context,
        TypeMsg.error,
        error is AppException ? error.message : l10n.ticketsUpdateError,
      );
    }
  }
}

class _CategoriesSection extends HookConsumerWidget {
  final TicketEvent event;
  final Future<void> Function() onUpdated;

  const _CategoriesSection({required this.event, required this.onUpdated});

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

      final created = await editNotifier.addCategory(event.id, category);
      if (!context.mounted) return;
      if (created != null) {
        displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
        await onUpdated();
      } else {
        displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
      }
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
                    if (!locked) ...[
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => _showCategoryEditDialog(
                          context,
                          ref,
                          event.id,
                          category,
                          onUpdated,
                        ),
                        child: Text(l10n.ticketsEditCategory),
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
    String eventId,
    Category category,
    Future<void> Function() onUpdated,
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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.ticketsEditCategory),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
              CheckboxListTile(
                value: disabled,
                onChanged: (v) => setState(() => disabled = v ?? false),
                title: Text(l10n.ticketsDisableCategory),
                contentPadding: EdgeInsets.zero,
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
              child: Text(l10n.ticketsSaveChanges),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final price = int.tryParse(priceController.text) ?? category.price;
    if (price != 0 && price < 1) {
      displayToast(context, TypeMsg.error, l10n.ticketsMinPriceError);
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

    final success = await editNotifier.updateCategory(eventId, updated);
    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      await onUpdated();
    } else {
      final error = ref.read(ticketEventEditProvider).error;
      displayToast(
        context,
        TypeMsg.error,
        error is AppException ? error.message : l10n.ticketsUpdateError,
      );
    }
  }
}

class _QuestionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final Future<void> Function() onUpdated;

  const _QuestionsSection({required this.event, required this.onUpdated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    if (event.questions.isEmpty) {
      return _SectionCard(
        title: l10n.ticketsQuestions,
        child: Text('-', style: TextStyle(color: ColorConstants.tertiary)),
      );
    }

    return _SectionCard(
      title: l10n.ticketsQuestions,
      child: Column(
        children: event.questions.map((question) {
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
                  Text(
                    question.question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => _showQuestionEditDialog(
                      context,
                      ref,
                      event.id,
                      question,
                      onUpdated,
                    ),
                    child: Text(l10n.ticketsEditTitle),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _showQuestionEditDialog(
    BuildContext context,
    WidgetRef ref,
    String eventId,
    Question question,
    Future<void> Function() onUpdated,
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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.ticketsEditTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                CheckboxListTile(
                  value: disabled,
                  onChanged: (v) => setState(() => disabled = v ?? false),
                  title: Text(l10n.ticketsDisableQuestion),
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
              child: Text(l10n.ticketsSaveChanges),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final price = priceController.text.isEmpty
        ? null
        : int.tryParse(priceController.text);

    final success = await editNotifier.updateQuestion(
      eventId,
      question.id,
      questionText: textController.text.trim(),
      answerType: answerType,
      required: required,
      price: price,
      disabled: disabled,
    );

    if (!context.mounted) return;
    if (success) {
      displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
      await onUpdated();
    } else {
      final error = ref.read(ticketEventEditProvider).error;
      displayToast(
        context,
        TypeMsg.error,
        error is AppException ? error.message : l10n.ticketsUpdateError,
      );
    }
  }
}
