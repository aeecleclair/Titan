import 'package:flutter/material.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:heroicons/heroicons.dart';

class _QuestionEntry {
  _QuestionEntry() {
    question = TextEditingController();
    choices = [TextEditingController(), TextEditingController()];
  }

  late final TextEditingController question;
  late final List<TextEditingController> choices;

  void dispose() {
    question.dispose();
    for (final c in choices) {
      c.dispose();
    }
  }
}

class CreateShotgunPage extends StatefulWidget {
  const CreateShotgunPage({super.key});

  @override
  State<CreateShotgunPage> createState() => _CreateShotgunPageState();
}

class _CreateShotgunPageState extends State<CreateShotgunPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _questions = <_QuestionEntry>[];

  @override
  void initState() {
    super.initState();
    _addQuestion();
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(_QuestionEntry());
    });
  }

  void _removeQuestion(int index) {
    if (_questions.length <= 1) return;
    setState(() {
      _questions[index].dispose();
      _questions.removeAt(index);
    });
  }

  void _addChoice(int questionIndex) {
    setState(() {
      _questions[questionIndex].choices.add(TextEditingController());
    });
  }

  void _removeChoice(int questionIndex, int choiceIndex) {
    final entry = _questions[questionIndex];
    if (entry.choices.length <= 2) return;
    setState(() {
      entry.choices[choiceIndex].dispose();
      entry.choices.removeAt(choiceIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShotgunTemplate(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "Créer un shotgun",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              const SizedBox(height: 24),
              TextEntry(
                maxLines: 1,
                label: "Titre du shotgun",
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              ...List.generate(_questions.length, (qIndex) {
                final entry = _questions[qIndex];
                return _QcmQuestionCard(
                  questionIndex: qIndex,
                  entry: entry,
                  canRemoveQuestion: _questions.length > 1,
                  onRemoveQuestion: () => _removeQuestion(qIndex),
                  onAddChoice: () => _addChoice(qIndex),
                  onRemoveChoice: (cIndex) => _removeChoice(qIndex, cIndex),
                );
              }),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _addQuestion,
                icon: const HeroIcon(HeroIcons.plus, size: 20),
                label: const Text("Ajouter une question"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstants.main,
                  side: const BorderSide(color: ColorConstants.main),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _QcmQuestionCard extends StatelessWidget {
  const _QcmQuestionCard({
    required this.questionIndex,
    required this.entry,
    required this.canRemoveQuestion,
    required this.onRemoveQuestion,
    required this.onAddChoice,
    required this.onRemoveChoice,
  });

  final int questionIndex;
  final _QuestionEntry entry;
  final bool canRemoveQuestion;
  final VoidCallback onRemoveQuestion;
  final VoidCallback onAddChoice;
  final void Function(int choiceIndex) onRemoveChoice;

  @override
  Widget build(BuildContext context) {
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
                    controller: entry.question,
                  ),
                ),
                if (canRemoveQuestion)
                  IconButton(
                    onPressed: onRemoveQuestion,
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
            ...List.generate(entry.choices.length, (cIndex) {
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
                        controller: entry.choices[cIndex],
                        canBeEmpty: true,
                      ),
                    ),
                    if (entry.choices.length > 2)
                      IconButton(
                        onPressed: () => onRemoveChoice(cIndex),
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
            }),
            TextButton.icon(
              onPressed: onAddChoice,
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
