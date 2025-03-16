import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/seed-library/providers/difficulty_filter_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/providers/species_provider.dart';
import 'package:myecl/seed-library/providers/species_type_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/ui/components/types_bar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';

class SpeciesAddEditPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  SpeciesAddEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final speciesListNotifier = ref.watch(speciesListProvider.notifier);
    final speciesList = ref.watch(syncSpeciesListProvider);
    final species = ref.watch(speciesProvider);
    final type = ref.watch(speciesTypeProvider);
    final difficulty = ref.watch(difficultyFilterProvider);
    final difficultyNotifier = ref.watch(difficultyFilterProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    bool isEdit = species.id != '';
    final name = useTextEditingController(text: species.name);
    final prefix = useTextEditingController(text: species.prefix);
    if (difficulty != species.difficulty) {
      difficultyNotifier.setFilter(species.difficulty);
    }
    final card = useTextEditingController(text: species.card);
    final nbSeedsRecommended =
        useTextEditingController(text: species.nbSeedsRecommended.toString());

    List<String> prefixes = speciesList.map((e) => e.prefix).toList();
    prefixes.removeWhere((element) => element == species.prefix);

    return PhonebookTemplate(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: isEdit
                    ? Text(
                        SeedLibraryTextConstants.editSpecies,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      )
                    : Text(
                        SeedLibraryTextConstants.addSpecies,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              TypesBar(),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                  TextEntry(
                    controller: name,
                    label: SeedLibraryTextConstants.name,
                    canBeEmpty: false,
                  ),
                  const SizedBox(height: 20),
                  TextEntry(
                    controller: prefix,
                    label: SeedLibraryTextConstants.prefix,
                    validator: (p0) => p0.isNotEmpty
                        ? prefixes.contains(p0)
                            ? SeedLibraryTextConstants.prefixError
                            : null
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text('Difficulty: '),
                  Slider(
                    value: difficulty.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: difficulty.toString(),
                    onChanged: (double value) {
                      difficultyNotifier.setFilter(value.toInt());
                    },
                  ),
                  const SizedBox(height: 20),
                  TextEntry(
                    controller: card,
                    label: SeedLibraryTextConstants.card,
                    canBeEmpty: true,
                  ),
                  const SizedBox(height: 20),
                  TextEntry(
                    controller: nbSeedsRecommended,
                    label: SeedLibraryTextConstants.nbSeedsRecommended,
                    canBeEmpty: true,
                    validator: (p0) => p0.isNotEmpty
                        ? int.tryParse(p0) == null
                            ? SeedLibraryTextConstants.nbSeedsRecommendedError
                            : int.tryParse(p0)! < 0
                                ? SeedLibraryTextConstants
                                    .nbSeedsRecommendedError
                                : null
                        : null,
                  ),
                  WaitingButton(
                    builder: (child) => AddEditButtonLayout(
                      colors: const [
                        ColorConstants.gradient1,
                        ColorConstants.gradient2,
                      ],
                      child: child,
                    ),
                    onTap: () async {
                      if (!key.currentState!.validate()) {
                        displayToastWithContext(
                          TypeMsg.error,
                          SeedLibraryTextConstants.emptyFieldError,
                        );
                        return;
                      }
                      if (type.name == "") {
                        displayToastWithContext(
                          TypeMsg.error,
                          SeedLibraryTextConstants.emptyTypeError,
                        );
                        return;
                      }
                      if (difficulty == 0) {
                        displayToastWithContext(
                          TypeMsg.error,
                          SeedLibraryTextConstants.emptyDifficultyError,
                        );
                        return;
                      }
                      if (isEdit) {
                        await tokenExpireWrapper(ref, () async {
                          final value = await speciesListNotifier.updateSpecies(
                            species.copyWith(
                              name: name.text,
                              prefix: prefix.text,
                              type: type,
                              difficulty: difficulty,
                              card: card.text,
                              nbSeedsRecommended:
                                  int.tryParse(nbSeedsRecommended.text),
                            ),
                          );
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              SeedLibraryTextConstants.updatedSpecies,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              SeedLibraryTextConstants.updatingError,
                            );
                          }
                        });
                        return;
                      }
                      await tokenExpireWrapper(ref, () async {
                        final value = await speciesListNotifier.createSpecies(
                          species.copyWith(
                            name: name.text,
                            prefix: prefix.text,
                            type: type,
                            difficulty: difficulty,
                            card: card.text,
                            nbSeedsRecommended:
                                int.tryParse(nbSeedsRecommended.text),
                          ),
                        );
                        if (value) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            SeedLibraryTextConstants.addedSpecies,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            SeedLibraryTextConstants.addingError,
                          );
                        }
                      });
                    },
                    child: const Text(
                      SeedLibraryTextConstants.add,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
