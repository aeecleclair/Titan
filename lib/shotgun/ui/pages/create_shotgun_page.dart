import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/providers/association_event_list_provider.dart';
import 'package:titan/paiement/class/user_store.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';
import 'package:titan/shotgun/class/category.dart';
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
    final questions = useState<List<TextEditingController>>([]);

    final locale = Localizations.localeOf(context);

    return ShotgunTemplate(
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
                label: "Titre du shotgun *",
                controller: titleController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              TextEntry(
                maxLines: 1,
                label: "Nombre de places disponibles (optionnel)",
                controller: placesController,
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),

              DateEntry(
                label: "Date d'ouverture du shotgun *",
                controller: startDateController,
                onTap: () => getFullDate(context, startDateController),
              ),

              DateEntry(
                label: "Date de fermeture du shotgun (optionnel)",
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
                  onPressed: () {
                    // Validation des champs obligatoires
                    if (titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Le titre est obligatoire"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (startDateController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("La date de début est obligatoire"),
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

                      // Nombre de places optionnel (0 par défaut)
                      int quota = 0;
                      if (placesController.text.trim().isNotEmpty) {
                        quota = int.parse(placesController.text);
                      }

                      shotgunListNotifier.createShotgun(
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
                              .map((c) => c.text.trim())
                              .where((t) => t.isNotEmpty)
                              .toList(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Erreur: ${e.toString()}"),
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

// ── Extra questions (free-text only) ─────────────────────────────────────────

class _ExtraQuestionsSection extends StatelessWidget {
  final List<TextEditingController> questions;
  final ValueChanged<List<TextEditingController>> onChanged;

  const _ExtraQuestionsSection({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(questions.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextEntry(
                    maxLines: 1,
                    label: "Question ${i + 1}",
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
                  tooltip: "Supprimer la question",
                ),
              ],
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: addQuestion,
          icon: const HeroIcon(HeroIcons.plus, size: 20),
          label: const Text("Ajouter une question"),
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorConstants.main,
            side: const BorderSide(color: ColorConstants.main),
          ),
        ),
      ],
    );
  }
}
