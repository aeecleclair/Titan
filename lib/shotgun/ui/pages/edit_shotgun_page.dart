import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/providers/selected_shotgun_provider.dart';
import 'package:titan/shotgun/providers/shotgun_edit_provider.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class EditShotgunPage extends HookConsumerWidget {
  const EditShotgunPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final shotgun = ref.watch(selectedShotgunProvider);
    final shotgunEditNotifier = ref.watch(shotgunEditProvider.notifier);
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());

    // Si aucun shotgun n'est sélectionné, rediriger
    if (shotgun == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        QR.back();
      });
      return const SizedBox.shrink();
    }

    // Controllers pour les champs principaux
    final titleController = useTextEditingController(text: shotgun.name);
    final placesController = useTextEditingController(
      text: shotgun.quota?.toString() ?? '',
    );
    final startDateController = useTextEditingController(
      text: dateFormatter.format(shotgun.openDatetime),
    );
    final endDateController = useTextEditingController(
      text: shotgun.closeDatetime != null
          ? dateFormatter.format(shotgun.closeDatetime!)
          : '',
    );

    // État pour les catégories, sessions et questions
    final categories = useState<List<Category>>(shotgun.categories);
    final sessions = useState<List<Session>>(shotgun.sessions);
    final questions = useState<List<TextEditingController>>(
      shotgun.questions
          .map((q) => TextEditingController(text: q.question))
          .toList(),
    );

    return ShotgunTemplate(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              l10n.shotgunEditTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
            const SizedBox(height: 24),
            TextEntry(
              maxLines: 1,
              label: l10n.shotgunTitleLabel,
              controller: titleController,
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            TextEntry(
              maxLines: 1,
              label: l10n.shotgunPlacesLabel,
              controller: placesController,
              onChanged: (_) {},
            ),
            const SizedBox(height: 24),
            DateEntry(
              label: l10n.shotgunStartDateLabel,
              controller: startDateController,
              onTap: () => getFullDate(context, startDateController),
            ),
            DateEntry(
              label: l10n.shotgunEndDateLabel,
              controller: endDateController,
              onTap: () => getFullDate(context, endDateController),
            ),
            const SizedBox(height: 16),
            _EditCategoriesSection(
              categories: categories.value,
              onChanged: (value) => categories.value = value,
            ),
            const SizedBox(height: 16),
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
                        content: Text(l10n.shotgunTitleRequired),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (startDateController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.shotgunStartDateRequired),
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

                    final updatedShotgun = shotgun.copyWith(
                      name: titleController.text.trim(),
                      quota: quota,
                      openDatetime: openDatetime,
                      closeDatetime: closeDatetime,
                      categories: categories.value,
                      sessions: sessions.value,
                    );

                    final success = await shotgunEditNotifier.editShotgun(
                      updatedShotgun,
                    );

                    if (success && context.mounted) {
                      // Mettre à jour les questions séparément
                      for (int i = 0; i < questions.value.length; i++) {
                        if (i < shotgun.questions.length) {
                          // Mise à jour d'une question existante
                          if (questions.value[i].text !=
                              shotgun.questions[i].question) {
                            await shotgunEditNotifier.updateQuestion(
                              shotgun.id,
                              shotgun.questions[i].id,
                              questions.value[i].text,
                            );
                          }
                        }
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.shotgunEditSuccess),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
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
                child: Text(l10n.shotgunSaveChanges),
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

class _EditCategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<List<Category>> onChanged;

  const _EditCategoriesSection({
    required this.categories,
    required this.onChanged,
  });

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
              l10n.shotgunTariffs,
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
                      child: TextEntry(
                        label: l10n.shotgunTariffLabel(i + 1),
                        controller: TextEditingController(text: category.name),
                        onChanged: (value) {
                          final updated = [...categories];
                          updated[i] = category.copyWith(name: value);
                          onChanged(updated);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 100,
                      child: TextEntry(
                        label: l10n.shotgunPriceLabel,
                        controller: TextEditingController(
                          text: category.price.toString(),
                        ),
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

class _EditSessionsSection extends StatelessWidget {
  final List<Session> sessions;
  final ValueChanged<List<Session>> onChanged;

  const _EditSessionsSection({required this.sessions, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', locale.toString());

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
                            label: l10n.shotgunSessionLabelNumbered(i + 1),
                            controller: TextEditingController(
                              text: session.name,
                            ),
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
                                  label: l10n.shotgunDateLabel,
                                  controller: TextEditingController(
                                    text: dateFormatter.format(
                                      session.startDatetime,
                                    ),
                                  ),
                                  onTap: () async {
                                    final controller = TextEditingController(
                                      text: dateFormatter.format(
                                        session.startDatetime,
                                      ),
                                    );
                                    await getFullDate(context, controller);
                                    if (controller.text.isNotEmpty) {
                                      final updated = [...sessions];
                                      updated[i] = session.copyWith(
                                        startDatetime: DateTime.parse(
                                          processDateBackWithHourMaybe(
                                            controller.text,
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
                                  label: l10n.shotgunQuotaLabel,
                                  controller: TextEditingController(
                                    text: session.quota.toString(),
                                  ),
                                  onChanged: (value) {
                                    final updated = [...sessions];
                                    updated[i] = session.copyWith(
                                      quota:
                                          int.tryParse(value) ?? session.quota,
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
              l10n.shotgunQuestions,
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
                        label: l10n.shotgunQuestionLabel(i + 1),
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
                      tooltip: l10n.shotgunDeleteQuestionTooltip,
                    ),
                  ],
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: addQuestion,
              icon: const HeroIcon(HeroIcons.plus, size: 20),
              label: Text(l10n.shotgunAddQuestion),
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
