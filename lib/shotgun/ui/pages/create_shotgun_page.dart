import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
import 'package:titan/feed/providers/association_event_list_provider.dart';
import 'package:titan/shotgun/providers/create_shotgun_form_provider.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class CreateShotgunPage extends HookConsumerWidget {
  const CreateShotgunPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final formState = ref.watch(createShotgunFormProvider);
    final formNotifier = ref.watch(createShotgunFormProvider.notifier);
    final titleController = useTextEditingController(text: formState.title);
    final placesController = useTextEditingController();
    final myAssociations = ref.watch(myAssociationListProvider);
    final associationEventsListNotifier = ref.watch(
      associationEventsListProvider.notifier,
    );
    final selectedAssociation = useState<Association?>(
      myAssociations.isNotEmpty ? myAssociations.first : null,
    );
    return ShotgunTemplate(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: HorizontalMultiSelect<Association>(
                  items: myAssociations,
                  selectedItem: selectedAssociation.value,
                  onItemSelected: (association) {
                    selectedAssociation.value = association;
                    associationEventsListNotifier.loadAssociationEventList(
                      association.id,
                    );
                  },
                  itemBuilder: (context, association, index, selected) => Text(
                    association.name,
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
                label: "Titre du shotgun",
                controller: titleController,
                onChanged: formNotifier.setTitle,
              ),
              const SizedBox(height: 16),
              TextEntry(
                maxLines: 1,
                label: "Nombre de places disponibles",
                controller: placesController,
                onChanged: formNotifier.setTitle,
              ),
              const SizedBox(height: 16),
              ...List.generate(formState.questions.length, (qIndex) {
                final question = formState.questions[qIndex];
                return _QcmQuestionCard(
                  key: ValueKey(question.id),
                  questionId: question.id,
                  questionIndex: qIndex,
                );
              }),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: formNotifier.addQuestion,
                icon: const HeroIcon(HeroIcons.plus, size: 20),
                label: const Text("Ajouter une question"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstants.main,
                  side: const BorderSide(color: ColorConstants.main),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: ColorConstants.main,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Enregistrer le shotgun"),
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

class _QcmQuestionCard extends HookConsumerWidget {
  const _QcmQuestionCard({
    super.key,
    required this.questionId,
    required this.questionIndex,
  });

  final String questionId;
  final int questionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(createShotgunFormProvider);
    final formNotifier = ref.watch(createShotgunFormProvider.notifier);
    final question = formState.getQuestion(questionId);
    if (question == null) return const SizedBox.shrink();

    final questionController = useTextEditingController(text: question.text);
    final canRemoveQuestion = formState.questions.length > 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
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
            Row(
              children: [
                Expanded(
                  child: TextEntry(
                    maxLines: 1,
                    label: "Question ${questionIndex + 1}",
                    controller: questionController,
                    onChanged: (v) =>
                        formNotifier.updateQuestionText(questionId, v),
                  ),
                ),
                if (canRemoveQuestion)
                  IconButton(
                    onPressed: () => formNotifier.removeQuestion(questionId),
                    icon: HeroIcon(
                      HeroIcons.trash,
                      size: 22,
                      color: ColorConstants.error,
                    ),
                    tooltip: "Supprimer la question",
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(question.choices.length, (cIndex) {
              return _QcmChoiceField(
                key: ValueKey('$questionId-$cIndex'),
                questionId: questionId,
                choiceIndex: cIndex,
              );
            }),
            TextButton.icon(
              onPressed: () => formNotifier.addChoice(questionId),
              icon: const HeroIcon(HeroIcons.plus, size: 18),
              label: const Text("Ajouter un choix"),
              style: TextButton.styleFrom(foregroundColor: ColorConstants.main),
            ),
          ],
        ),
      ),
    );
  }
}

class _QcmChoiceField extends HookConsumerWidget {
  const _QcmChoiceField({
    super.key,
    required this.questionId,
    required this.choiceIndex,
  });

  final String questionId;
  final int choiceIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(createShotgunFormProvider);
    final formNotifier = ref.watch(createShotgunFormProvider.notifier);
    final question = formState.getQuestion(questionId);
    if (question == null || choiceIndex >= question.choices.length) {
      return const SizedBox.shrink();
    }

    final choiceText = question.choices[choiceIndex];
    final choiceController = useTextEditingController(text: choiceText);
    final canRemoveChoice = question.choices.length > 2;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextEntry(
              maxLines: 1,
              label: "Réponse possible",
              controller: choiceController,
              canBeEmpty: true,
              onChanged: (v) =>
                  formNotifier.updateChoice(questionId, choiceIndex, v),
            ),
          ),
          if (canRemoveChoice)
            IconButton(
              onPressed: () =>
                  formNotifier.removeChoice(questionId, choiceIndex),
              icon: HeroIcon(
                HeroIcons.minusCircle,
                size: 22,
                color: ColorConstants.error,
              ),
              tooltip: "Supprimer le choix",
            ),
        ],
      ),
    );
  }
}
