import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class EditTicketEventPage extends HookConsumerWidget {
  const EditTicketEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ticketEvent = ref.watch(selectedTicketEventProvider);
    final ticketEventEditNotifier = ref.watch(ticketEventEditProvider.notifier);
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());

    // Si aucun (ticketEvent) n'est sélectionné, rediriger
    if (ticketEvent == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        QR.back();
      });
      return const SizedBox.shrink();
    }

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

    // Debug prints
    debugPrint('=== EditTicketEventPage DEBUG ===');
    debugPrint('TicketEvent ID: ${ticketEvent.id}');
    debugPrint('TicketEvent name: ${ticketEvent.name}');
    debugPrint('Categories count: ${ticketEvent.categories.length}');
    debugPrint('Categories: ${ticketEvent.categories}');
    debugPrint('Sessions count: ${ticketEvent.sessions.length}');
    debugPrint('Sessions: ${ticketEvent.sessions}');
    debugPrint('Questions count: ${ticketEvent.questions.length}');

    // État pour les catégories, sessions et questions
    final categories = useState<List<Category>>(ticketEvent.categories);
    final sessions = useState<List<Session>>(ticketEvent.sessions);
    final questions = useState<List<TextEditingController>>(
      ticketEvent.questions
          .map((q) => TextEditingController(text: q.question))
          .toList(),
    );

    return TicketTemplate(
      child: SingleChildScrollView(
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
            const SizedBox(height: 16),
            if (categories.value.isEmpty)
              Card(
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
                        l10n.ticketsTariffs,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'DEBUG: Aucune catégorie trouvée',
                        style: TextStyle(color: ColorConstants.error),
                      ),
                    ],
                  ),
                ),
              )
            else
              _EditCategoriesSection(
                categories: categories.value,
                onChanged: (value) => categories.value = value,
              ),
            const SizedBox(height: 16),
            if (sessions.value.isEmpty)
              Card(
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'DEBUG: Aucune session trouvée',
                        style: TextStyle(color: ColorConstants.error),
                      ),
                    ],
                  ),
                ),
              )
            else
              _EditSessionsSection(
                sessions: sessions.value,
                onChanged: (value) => sessions.value = value,
              ),
            const SizedBox(height: 16),
            _EditQuestionsSection(
              questions: questions.value,
              onChanged: (value) => questions.value = value,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  // Validation
                  if (titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.ticketsTitleRequired),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (startDateController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.ticketsStartDateRequired),
                        backgroundColor: Colors.red,
                      ),
                    );
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

                    int quota = 0;
                    if (placesController.text.trim().isNotEmpty) {
                      quota = int.parse(placesController.text);
                    }

                    // Mettre à jour l'événement principal
                    final success = await ticketEventEditNotifier
                        .editTicketEvent(
                          ticketEvent.copyWith(
                            name: titleController.text.trim(),
                            quota: quota,
                            openDatetime: openDatetime,
                            closeDatetime: closeDatetime,
                          ),
                        );

                    if (!success || !context.mounted) return;

                    // Mettre à jour les catégories modifiées
                    for (int i = 0; i < categories.value.length; i++) {
                      if (i < ticketEvent.categories.length) {
                        final original = ticketEvent.categories[i];
                        final updated = categories.value[i];
                        if (original.name != updated.name ||
                            original.price != updated.price) {
                          await ticketEventEditNotifier.updateCategory(
                            ticketEvent.id,
                            updated,
                          );
                        }
                      }
                    }

                    if (!context.mounted) return;

                    // Mettre à jour les sessions modifiées
                    for (int i = 0; i < sessions.value.length; i++) {
                      if (i < ticketEvent.sessions.length) {
                        final original = ticketEvent.sessions[i];
                        final updated = sessions.value[i];
                        if (original.name != updated.name ||
                            original.startDatetime != updated.startDatetime ||
                            original.quota != updated.quota) {
                          await ticketEventEditNotifier.updateSession(
                            ticketEvent.id,
                            updated,
                          );
                        }
                      }
                    }

                    if (!context.mounted) return;

                    // Mettre à jour les questions modifiées
                    for (int i = 0; i < questions.value.length; i++) {
                      if (i < ticketEvent.questions.length) {
                        if (questions.value[i].text !=
                            ticketEvent.questions[i].question) {
                          await ticketEventEditNotifier.updateQuestion(
                            ticketEvent.id,
                            ticketEvent.questions[i].id,
                            questions.value[i].text,
                          );
                        }
                      }
                    }

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.ticketsEditSuccess),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${l10n.othersError}: ${e.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: ColorConstants.main,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(l10n.ticketsSaveChanges),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// ── Edit Categories Section ──────────────────────────────────────────────────

class _EditCategoriesSection extends HookWidget {
  final List<Category> categories;
  final ValueChanged<List<Category>> onChanged;

  const _EditCategoriesSection({
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Create stable controllers using useMemoized
    final nameControllers = useMemoized(
      () => categories.map((c) => TextEditingController(text: c.name)).toList(),
      [],
    );
    final priceControllers = useMemoized(
      () => categories
          .map((c) => TextEditingController(text: c.price.toString()))
          .toList(),
      [],
    );

    // Update controllers when categories change externally
    useEffect(() {
      for (int i = 0; i < categories.length; i++) {
        if (i < nameControllers.length) {
          if (nameControllers[i].text != categories[i].name) {
            nameControllers[i].text = categories[i].name;
          }
          if (priceControllers[i].text != categories[i].price.toString()) {
            priceControllers[i].text = categories[i].price.toString();
          }
        }
      }
      return null;
    }, [categories]);

    // Dispose controllers
    useEffect(() {
      return () {
        for (final c in nameControllers) c.dispose();
        for (final c in priceControllers) c.dispose();
      };
    }, []);

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
              l10n.ticketsTariffs,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(categories.length, (i) {
              final category = categories[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextEntry(
                        label: l10n.ticketsTariffLabel(i + 1),
                        controller: nameControllers[i],
                        onChanged: (value) {
                          final updated = [...categories];
                          updated[i] = category.copyWith(name: value);
                          onChanged(updated);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextEntry(
                        label: l10n.ticketsPriceLabel,
                        controller: priceControllers[i],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final updated = [...categories];
                          updated[i] = category.copyWith(
                            price: int.tryParse(value) ?? category.price,
                          );
                          onChanged(updated);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Edit Sessions Section ────────────────────────────────────────────────────

class _EditSessionsSection extends HookWidget {
  final List<Session> sessions;
  final ValueChanged<List<Session>> onChanged;

  const _EditSessionsSection({required this.sessions, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());

    // Create stable controllers using useMemoized
    final nameControllers = useMemoized(
      () => sessions.map((s) => TextEditingController(text: s.name)).toList(),
      [],
    );
    final dateControllers = useMemoized(
      () => sessions
          .map(
            (s) => TextEditingController(
              text: dateFormatter.format(s.startDatetime),
            ),
          )
          .toList(),
      [],
    );
    final quotaControllers = useMemoized(
      () => sessions
          .map((s) => TextEditingController(text: s.quota?.toString() ?? ''))
          .toList(),
      [],
    );

    // Update controllers when sessions change externally
    useEffect(() {
      for (int i = 0; i < sessions.length; i++) {
        if (i < nameControllers.length) {
          if (nameControllers[i].text != sessions[i].name) {
            nameControllers[i].text = sessions[i].name;
          }
          final dateText = dateFormatter.format(sessions[i].startDatetime);
          if (dateControllers[i].text != dateText) {
            dateControllers[i].text = dateText;
          }
          final quotaText = sessions[i].quota?.toString() ?? '';
          if (quotaControllers[i].text != quotaText) {
            quotaControllers[i].text = quotaText;
          }
        }
      }
      return null;
    }, [sessions]);

    // Dispose controllers
    useEffect(() {
      return () {
        for (final c in nameControllers) c.dispose();
        for (final c in dateControllers) c.dispose();
        for (final c in quotaControllers) c.dispose();
      };
    }, []);

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
            ...List.generate(sessions.length, (i) {
              final session = sessions[i];
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
                            label: l10n.ticketsSessionLabelNumbered(i + 1),
                            controller: nameControllers[i],
                            onChanged: (value) {
                              final updated = [...sessions];
                              updated[i] = session.copyWith(name: value);
                              onChanged(updated);
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: DateEntry(
                                  label: l10n.ticketsDateLabel,
                                  controller: dateControllers[i],
                                  onTap: () async {
                                    await getFullDate(
                                      context,
                                      dateControllers[i],
                                    );
                                    if (dateControllers[i].text.isNotEmpty) {
                                      final updated = [...sessions];
                                      updated[i] = session.copyWith(
                                        startDatetime: DateTime.parse(
                                          processDateBackWithHourMaybe(
                                            dateControllers[i].text,
                                            locale.toString(),
                                          ),
                                        ),
                                      );
                                      onChanged(updated);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: TextEntry(
                                  label: l10n.ticketsQuotaLabel,
                                  controller: quotaControllers[i],
                                  keyboardType: TextInputType.number,
                                  canBeEmpty: true,
                                  onChanged: (value) {
                                    final updated = [...sessions];
                                    updated[i] = session.copyWith(
                                      quota: value.isEmpty
                                          ? null
                                          : int.tryParse(value),
                                    );
                                    onChanged(updated);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Edit Questions Section ──────────────────────────────────────────────────

class _EditQuestionsSection extends StatelessWidget {
  final List<TextEditingController> questions;
  final ValueChanged<List<TextEditingController>> onChanged;

  const _EditQuestionsSection({
    required this.questions,
    required this.onChanged,
  });

  void addQuestion() {
    onChanged([...questions, TextEditingController()]);
  }

  void removeQuestion(int index) {
    final updated = [...questions]..removeAt(index);
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              l10n.ticketsQuestions,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(questions.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextEntry(
                        maxLines: 1,
                        label: l10n.ticketsQuestionLabel(i + 1),
                        controller: questions[i],
                        onChanged: (_) {},
                      ),
                    ),
                    IconButton(
                      onPressed: () => removeQuestion(i),
                      icon: HeroIcon(
                        HeroIcons.minusCircle,
                        size: 22,
                        color: ColorConstants.error,
                      ),
                      tooltip: l10n.ticketsDeleteQuestionTooltip,
                    ),
                  ],
                ),
              );
            }),
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
      ),
    );
  }
}
