import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/feed/providers/association_event_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/shotgun/class/answer_type.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/question.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/ui/components/session_card.dart';
import 'package:titan/shotgun/ui/components/tarif_card.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/shotgun/providers/shotgun_list_provider.dart';

enum QuestionType { tarif, quota }

class CreateShotgunPage extends HookConsumerWidget {
  const CreateShotgunPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final shotgunListNotifier = ref.watch(shotgunListProvider.notifier);
    final startDateController = useTextEditingController();
    final endDateController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final titleController = useTextEditingController();
    final placesController = useTextEditingController();
    final myStores = ref.watch(myStoresProvider);
    final associationEventsListNotifier = ref.watch(
      associationEventsListProvider.notifier,
    );
    final selectedStore = useState<UserStore?>(
      myStores.valueOrNull?.isNotEmpty ?? false
          ? myStores.valueOrNull?.first
          : null,
    );
    final categories = useState<List<Category>>([]);
    final sessions = useState<List<Session>>([]);
    final questions = useState<List<_QuestionFormData>>([]);

    final locale = Localizations.localeOf(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ShotgunTemplate(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: HorizontalMultiSelect<UserStore>(
                    items: myStores.valueOrNull ?? [],
                    selectedItem: selectedStore.value,
                    onItemSelected: (store) {
                      selectedStore.value = store;
                      associationEventsListNotifier.loadAssociationEventList(
                        store.id,
                      );
                    },
                    itemBuilder: (context, store, index, selected) => Text(
                      store.name,
                      style: TextStyle(
                        color: selected
                            ? ColorConstants.background
                            : ColorConstants.tertiary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextEntry(
                  maxLines: 1,
                  label: l10n.shotgunTitleLabel,
                  controller: titleController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) {},
                ),
                const SizedBox(height: 16),
                TextEntry(
                  maxLines: 1,
                  label: l10n.shotgunPlacesLabel,
                  controller: placesController,
                  keyboardType: TextInputType.number,
                  isInt: true,
                  canBeEmpty: true,
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

                TarifCard(onChanged: (value) => categories.value = value),
                const SizedBox(height: 16),

                SessionCard(onChanged: (value) => sessions.value = value),
                const SizedBox(height: 16),
                _ExtraQuestionsSection(
                  questions: questions.value,
                  onChanged: (value) => questions.value = value,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      // Validation des champs obligatoires
                      if (titleController.text.trim().isEmpty) {
                        displayToast(
                          context,
                          TypeMsg.error,
                          l10n.shotgunTitleRequired,
                        );
                        return;
                      }

                      if (startDateController.text.trim().isEmpty) {
                        displayToast(
                          context,
                          TypeMsg.error,
                          l10n.shotgunStartDateRequired,
                        );
                        return;
                      }

                      if (categories.value.isEmpty) {
                        displayToast(
                          context,
                          TypeMsg.error,
                          l10n.shotgunCategoriesRequired,
                        );
                        return;
                      }

                      if (sessions.value.isEmpty) {
                        displayToast(
                          context,
                          TypeMsg.error,
                          l10n.shotgunSessionsRequired,
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

                        // Date de fin optionnelle
                        DateTime? closeDatetime;
                        if (endDateController.text.trim().isNotEmpty) {
                          closeDatetime = DateTime.parse(
                            processDateBackWithHourMaybe(
                              endDateController.text,
                              locale.toString(),
                            ),
                          );
                        }

                        // Nombre de places optionnel (null si vide)
                        int? quota;
                        if (placesController.text.trim().isNotEmpty) {
                          quota = int.parse(placesController.text);
                        }

                        final success = await shotgunListNotifier.createShotgun(
                          Shotgun(
                            id: '',
                            name: titleController.text.trim(),
                            storeId: selectedStore.value?.id ?? '',
                            quota: quota,
                            openDatetime: openDatetime,
                            closeDatetime: closeDatetime,
                            categories: categories.value,
                            sessions: sessions.value,
                            questions: questions.value
                                .where(
                                  (q) => q.controller.text.trim().isNotEmpty,
                                )
                                .map(
                                  (q) => Question(
                                    id: '',
                                    eventId: '',
                                    question: q.controller.text.trim(),
                                    answerType: q.answerType,
                                    price: null,
                                    required: q.required,
                                    disabled: false,
                                  ),
                                )
                                .toList(),
                          ),
                        );

                        if (success && context.mounted) {
                          displayToast(
                            context,
                            TypeMsg.msg,
                            l10n.shotgunReservationSuccess,
                          );
                          QR.back();
                        }
                      } catch (e) {
                        if (context.mounted) {
                          displayToast(
                            context,
                            TypeMsg.error,
                            "${l10n.othersError}: ${e.toString()}",
                          );
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: ColorConstants.main,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(l10n.shotgunSave),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Helper class for question form data ──────────────────────────────────────

class _QuestionFormData {
  final TextEditingController controller;
  AnswerType answerType;
  bool required;

  _QuestionFormData({
    required this.controller,
    this.answerType = AnswerType.text,
    this.required = false,
  });
}

// ── Extra questions section with type and required options ───────────────────

class _ExtraQuestionsSection extends StatelessWidget {
  final List<_QuestionFormData> questions;
  final ValueChanged<List<_QuestionFormData>> onChanged;

  const _ExtraQuestionsSection({
    required this.questions,
    required this.onChanged,
  });

  void addQuestion() {
    onChanged([
      ...questions,
      _QuestionFormData(controller: TextEditingController()),
    ]);
  }

  void removeQuestion(int index) {
    final updated = [...questions]..removeAt(index);
    onChanged(updated);
  }

  void updateQuestion(int index, _QuestionFormData updated) {
    final updatedList = [...questions];
    updatedList[index] = updated;
    onChanged(updatedList);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(questions.length, (i) {
          final question = questions[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
                            label: l10n.shotgunQuestionLabel(i + 1),
                            controller: question.controller,
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<AnswerType>(
                            initialValue: question.answerType,
                            decoration: InputDecoration(
                              labelText: l10n.shotgunQuestionTypeLabel,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: AnswerType.text,
                                child: Text(l10n.shotgunAnswerTypeText),
                              ),
                              DropdownMenuItem(
                                value: AnswerType.number,
                                child: Text(l10n.shotgunAnswerTypeNumber),
                              ),
                              DropdownMenuItem(
                                value: AnswerType.boolean,
                                child: Text(l10n.shotgunAnswerTypeBoolean),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                updateQuestion(
                                  i,
                                  _QuestionFormData(
                                    controller: question.controller,
                                    answerType: value,
                                    required: question.required,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: question.required,
                              onChanged: (value) {
                                updateQuestion(
                                  i,
                                  _QuestionFormData(
                                    controller: question.controller,
                                    answerType: question.answerType,
                                    required: value ?? false,
                                  ),
                                );
                              },
                              activeColor: ColorConstants.main,
                            ),
                            Text(l10n.shotgunQuestionRequiredLabel),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    );
  }
}
