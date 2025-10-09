import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/difficulty_filter_provider.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/providers/species_provider.dart';
import 'package:titan/seed-library/providers/species_type_provider.dart';
import 'package:titan/seed-library/providers/string_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/ui/components/types_bar.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditSpeciesPage extends HookConsumerWidget {
  const AddEditSpeciesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final speciesListNotifier = ref.watch(speciesListProvider.notifier);
    final speciesList = ref.watch(syncSpeciesListProvider);
    final species = ref.watch(speciesProvider);
    final type = ref.watch(speciesTypeProvider);
    final difficulty = ref.watch(difficultyFilterProvider);
    final difficultyNotifier = ref.watch(difficultyFilterProvider.notifier);

    bool isEdit = species.id != '';
    final name = useTextEditingController(text: species.name);
    final prefix = useTextEditingController(text: species.prefix);
    final card = useTextEditingController(text: species.card);
    final nbSeedsRecommended = useTextEditingController(
      text: species.nbSeedsRecommended != null
          ? species.nbSeedsRecommended.toString()
          : '',
    );
    final startMonth = ref.watch(startMonthProvider);
    final endMonth = ref.watch(endMonthProvider);
    final startMonthNotifier = ref.watch(startMonthProvider.notifier);
    final endMonthNotifier = ref.watch(endMonthProvider.notifier);
    final maturationTime = useTextEditingController(
      text: species.timeMaturation != null
          ? species.timeMaturation.toString()
          : '',
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<String> prefixes = speciesList.map((e) => e.prefix).toList();
    prefixes.removeWhere((element) => element == species.prefix);

    return SeedLibraryTemplate(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(height: 30),
                isEdit
                    ? Text(
                        SeedLibraryTextConstants.editSpecies,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        SeedLibraryTextConstants.addSpecies,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(height: 30),
                TypesBar(),
                Column(
                  children: [
                    Container(margin: const EdgeInsets.symmetric(vertical: 10)),
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
                          ? p0.length != 3
                                ? SeedLibraryTextConstants.prefixLengthError
                                : prefixes.contains(p0)
                                ? SeedLibraryTextConstants.prefixError
                                : null
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text(SeedLibraryTextConstants.difficulty),
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
                                ? SeedLibraryTextConstants
                                      .nbSeedsRecommendedError
                                : int.tryParse(p0)! < 0
                                ? SeedLibraryTextConstants
                                      .nbSeedsRecommendedError
                                : null
                          : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      SeedLibraryTextConstants.plantationPeriod,
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            Text(SeedLibraryTextConstants.startMonth),
                            DropdownButton(
                              items: ["", ...SeedLibraryTextConstants.months]
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? value) {
                                startMonthNotifier.setString(value!);
                              },
                              value: startMonth,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text(SeedLibraryTextConstants.endMonth),
                            DropdownButton(
                              items: ["", ...SeedLibraryTextConstants.months]
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? value) {
                                endMonthNotifier.setString(value!);
                              },
                              value: endMonth,
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextEntry(
                      controller: maturationTime,
                      label: SeedLibraryTextConstants.maturationTime,
                      canBeEmpty: true,
                      isInt: true,
                    ),
                    const SizedBox(height: 20),
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
                        if (type.name == SeedLibraryTextConstants.all) {
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
                            final value = await speciesListNotifier
                                .updateSpecies(
                                  species.copyWith(
                                    name: name.text,
                                    prefix: prefix.text,
                                    type: type,
                                    difficulty: difficulty,
                                    card: card.text,
                                    nbSeedsRecommended: int.tryParse(
                                      nbSeedsRecommended.text,
                                    ),
                                    startSeason: startMonth.isNotEmpty
                                        ? DateTime(
                                            2021,
                                            SeedLibraryTextConstants.months
                                                    .indexOf(startMonth) +
                                                1,
                                            1,
                                          )
                                        : null,
                                    endSeason: endMonth.isNotEmpty
                                        ? DateTime(
                                            2021,
                                            SeedLibraryTextConstants.months
                                                    .indexOf(endMonth) +
                                                1,
                                            1,
                                          )
                                        : null,
                                    timeMaturation: int.tryParse(
                                      maturationTime.text,
                                    ),
                                  ),
                                );
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                SeedLibraryTextConstants.updatedSpecies,
                              );
                              QR.back();
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
                              nbSeedsRecommended: int.tryParse(
                                nbSeedsRecommended.text,
                              ),
                              startSeason: startMonth.isNotEmpty
                                  ? DateTime(
                                      2021,
                                      SeedLibraryTextConstants.months.indexOf(
                                            startMonth,
                                          ) +
                                          1,
                                      1,
                                    )
                                  : null,
                              endSeason: endMonth.isNotEmpty
                                  ? DateTime(
                                      2021,
                                      SeedLibraryTextConstants.months.indexOf(
                                            endMonth,
                                          ) +
                                          1,
                                      1,
                                    )
                                  : null,
                              timeMaturation: int.tryParse(maturationTime.text),
                            ),
                          );
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              SeedLibraryTextConstants.addedSpecies,
                            );
                            QR.back();
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              SeedLibraryTextConstants.addingError,
                            );
                          }
                        });
                      },
                      child: Text(
                        isEdit
                            ? SeedLibraryTextConstants.update
                            : SeedLibraryTextConstants.add,
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
      ),
    );
  }
}
