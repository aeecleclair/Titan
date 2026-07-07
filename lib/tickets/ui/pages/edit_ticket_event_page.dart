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
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/providers/store_tickets_list_provider.dart';
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tickets/providers/ticket_event_provider.dart';
import 'package:titan/tickets/ui/components/edit_ticket_event_helpers.dart';
import 'package:titan/tickets/ui/components/read_only_banner.dart';
import 'package:titan/tickets/ui/components/sessions_section.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
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
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(
            context,
          ).colorScheme.copyWith(primary: ColorConstants.main),
        ),
        child: AsyncChild(
          value: eventAsync,
          builder: (context, event) => _EditTicketEventContent(event: event),
        ),
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

      if (!await showDeleteConfirm(context, ref)) {
        return;
      }
      if (!context.mounted) return;

      await tokenExpireWrapper(ref, () async {
        final success = await editNotifier.deleteTicketEvent(event.id);
        if (!context.mounted) return;

        if (success) {
          ref.read(selectedTicketEventProvider.notifier).clear();
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
          showEditError(
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
            SectionCard(
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
                  if (!canDeleteEvent)
                    ReadOnlyBanner(message: l10n.ticketsCannotDeleteDueSales),
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
            SessionsSection(event: event, onEventUpdated: onEventUpdated),
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

void _updateTicketEventState(WidgetRef ref, TicketEvent updated) {
  ref.read(ticketEventByIdProvider(updated.id).notifier).setEvent(updated);
  ref.read(selectedTicketEventProvider.notifier).setEvent(updated);
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
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: _GeneralInfoEditModal(
      parentContext: context,
      event: event,
      onEventUpdated: onEventUpdated,
    ),
  );
}

class _GeneralInfoEditModal extends HookConsumerWidget {
  const _GeneralInfoEditModal({
    required this.parentContext,
    required this.event,
    required this.onEventUpdated,
  });

  final BuildContext parentContext;
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());
    final editNotifier = ref.read(ticketEventEditProvider.notifier);

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

    return BottomModalTemplate(
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
            const SizedBox(height: 20),
            Button(
              text: l10n.ticketsSaveChanges,
              onPressed: () async {
                if (titleController.text.trim().isEmpty) {
                  displayToast(
                    context,
                    TypeMsg.error,
                    l10n.ticketsTitleRequired,
                  );
                  return;
                }
                if (startDateController.text.trim().isEmpty) {
                  displayToast(
                    context,
                    TypeMsg.error,
                    l10n.ticketsStartDateRequired,
                  );
                  return;
                }

                Navigator.pop(context);
                if (!parentContext.mounted) return;

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
                    final success = await editNotifier.editTicketEvent(updated);

                    if (!parentContext.mounted) return;
                    if (success) {
                      displayToast(
                        parentContext,
                        TypeMsg.msg,
                        l10n.ticketsEditSuccess,
                      );
                      onEventUpdated(updated);
                    } else {
                      showEditError(parentContext, ref, l10n);
                    }
                  });
                } catch (e) {
                  if (parentContext.mounted) {
                    displayToast(parentContext, TypeMsg.error, e.toString());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
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
      showEditError(context, ref, l10n);
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
      showEditError(context, ref, l10n);
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
      showEditError(context, ref, l10n);
    }
  });
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
      final result = await showDialog<_CategoryFormResult>(
        context: context,
        builder: (ctx) =>
            _AddCategoryDialog(tariffIndex: event.categories.length + 1),
      );

      if (result == null || !context.mounted) return;
      if (result.name.isEmpty) return;

      final price = int.tryParse(result.priceText) ?? 0;
      if (price != 0 && price < 1) {
        displayToast(context, TypeMsg.error, l10n.ticketsMinPriceError);
        return;
      }

      final category = Category(
        id: '',
        name: result.name,
        price: price,
        quota: result.quotaText.isEmpty ? null : int.tryParse(result.quotaText),
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

    return SectionCard(
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
                    if (locked) const ReadOnlyBanner(),
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
                              if (!await showDeleteConfirm(context, ref)) {
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
            onPressed: addCategory,
            icon: const HeroIcon(HeroIcons.plus, size: 20),
            label: Text(l10n.ticketsAddCategory),
          ),
        ],
      ),
    );
  }
}

Future<void> _showCategoryEditDialog(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Category category,
  void Function(TicketEvent) onEventUpdated,
) async {
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: _CategoryEditModal(
      parentContext: context,
      event: event,
      category: category,
      onEventUpdated: onEventUpdated,
    ),
  );
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

class _AddCategoryDialog extends HookConsumerWidget {
  const _AddCategoryDialog({required this.tariffIndex});

  final int tariffIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController();
    final priceController = useTextEditingController(text: '0');
    final quotaController = useTextEditingController();

    return AlertDialog(
      title: Text(l10n.ticketsAddCategory),
      content: Column(
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
          child: Text(l10n.ticketsSave),
        ),
      ],
    );
  }
}

class _CategoryEditModal extends HookConsumerWidget {
  const _CategoryEditModal({
    required this.parentContext,
    required this.event,
    required this.category,
    required this.onEventUpdated,
  });

  final BuildContext parentContext;
  final TicketEvent event;
  final Category category;
  final void Function(TicketEvent) onEventUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.read(ticketEventEditProvider.notifier);
    final nameController = useTextEditingController(text: category.name);
    final priceController = useTextEditingController(
      text: category.price.toString(),
    );
    final quotaController = useTextEditingController(
      text: category.quota?.toString() ?? '',
    );
    final disabled = useState(category.disabled);

    return BottomModalTemplate(
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
            value: !disabled.value,
            onChanged: (v) => disabled.value = !v,
            title: Text(
              disabled.value
                  ? l10n.ticketsCategoryDeactivated
                  : l10n.ticketsCategoryActivated,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          Button(
            text: l10n.ticketsSaveChanges,
            onPressed: () async {
              Navigator.pop(context);
              if (!parentContext.mounted) return;

              final price =
                  int.tryParse(priceController.text) ?? category.price;
              if (price != 0 && price < 1) {
                displayToast(
                  parentContext,
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
                disabled: disabled.value,
              );

              await tokenExpireWrapper(ref, () async {
                final success = await editNotifier.updateCategory(
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
                  onEventUpdated(_withCategory(event, updated));
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

class _QuestionsSection extends HookConsumerWidget {
  final TicketEvent event;
  final void Function(TicketEvent) onEventUpdated;

  const _QuestionsSection({required this.event, required this.onEventUpdated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.watch(ticketEventEditProvider.notifier);

    Future<void> addQuestion() async {
      final result = await showDialog<_QuestionFormResult>(
        context: context,
        builder: (ctx) =>
            _AddQuestionDialog(questionIndex: event.questions.length + 1),
      );

      if (result == null || !context.mounted) return;
      if (result.text.isEmpty) return;

      final price = result.priceText.isEmpty
          ? null
          : int.tryParse(result.priceText);

      await tokenExpireWrapper(ref, () async {
        final created = await editNotifier.createQuestion(
          event.id,
          questionText: result.text,
          answerType: result.answerType,
          required: result.required,
          price: price,
        );

        if (!context.mounted) return;
        if (created != null) {
          displayToast(context, TypeMsg.msg, l10n.ticketsEditSuccess);
          onEventUpdated(
            event.copyWith(questions: [...event.questions, created]),
          );
        } else {
          showEditError(context, ref, l10n);
        }
      });
    }

    return SectionCard(
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
            final locked = event.ticketsSold + event.ticketsInCheckout > 0;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              color: question.disabled || locked ? Colors.grey.shade100 : null,
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
                    if (locked)
                      ReadOnlyBanner(message: l10n.ticketsReadOnlyDueAnswers),
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
                    if (!locked)
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
                              if (!await showDeleteConfirm(context, ref)) return;
                              if (!context.mounted) return;
                              await tokenExpireWrapper(ref, () async {
                                final success = await editNotifier
                                    .deleteQuestion(event.id, question.id);
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
                                  showEditError(
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
}

Future<void> _showQuestionEditDialog(
  BuildContext context,
  WidgetRef ref,
  TicketEvent event,
  Question question,
  void Function(TicketEvent) onEventUpdated,
) async {
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: _QuestionEditModal(
      parentContext: context,
      event: event,
      question: question,
      onEventUpdated: onEventUpdated,
    ),
  );
}

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

class _AddQuestionDialog extends HookConsumerWidget {
  const _AddQuestionDialog({required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: Text(l10n.ticketsSave),
        ),
      ],
    );
  }
}

class _QuestionEditModal extends HookConsumerWidget {
  const _QuestionEditModal({
    required this.parentContext,
    required this.event,
    required this.question,
    required this.onEventUpdated,
  });

  final BuildContext parentContext;
  final TicketEvent event;
  final Question question;
  final void Function(TicketEvent) onEventUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editNotifier = ref.read(ticketEventEditProvider.notifier);
    final textController = useTextEditingController(text: question.question);
    final priceController = useTextEditingController(
      text: question.price?.toString() ?? '',
    );
    final answerType = useState(question.answerType);
    final required = useState(question.required);
    final disabled = useState(question.disabled);

    return BottomModalTemplate(
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
              initialValue: answerType.value,
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
                if (v != null) answerType.value = v;
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
              onChanged: (v) => required.value = v ?? false,
              title: Text(l10n.ticketsQuestionRequiredLabel),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: !disabled.value,
              onChanged: (v) => disabled.value = !v,
              title: Text(
                disabled.value
                    ? l10n.ticketsQuestionDeactivated
                    : l10n.ticketsQuestionActivated,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            Button(
              text: l10n.ticketsSaveChanges,
              onPressed: () async {
                Navigator.pop(context);
                if (!parentContext.mounted) return;

                final price = priceController.text.isEmpty
                    ? null
                    : int.tryParse(priceController.text);

                final updatedQuestion = question.copyWith(
                  question: textController.text.trim(),
                  answerType: answerType.value,
                  required: required.value,
                  price: price,
                  disabled: disabled.value,
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

                  if (!parentContext.mounted) return;
                  if (success) {
                    displayToast(
                      parentContext,
                      TypeMsg.msg,
                      l10n.ticketsEditSuccess,
                    );
                    onEventUpdated(_withQuestion(event, updatedQuestion));
                  } else {
                    showEditError(parentContext, ref, l10n);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
