import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/seed-library/class/plant_complete.dart';
import 'package:titan/seed-library/providers/plant_complete_provider.dart';
import 'package:titan/seed-library/providers/plants_list_provider.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart' as function;
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class EditablePlantDetail extends HookConsumerWidget {
  final PlantComplete plant;
  const EditablePlantDetail({super.key, required this.plant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final species = ref.watch(syncSpeciesListProvider);
    final plantNotifier = ref.watch(plantProvider.notifier);
    final myPlantsNotifier = ref.watch(myPlantListProvider.notifier);
    final name = TextEditingController(
      text: plant.nickname ?? plant.plantReference,
    );
    final notes = TextEditingController(text: plant.currentNote ?? '');
    final plantationDate = TextEditingController(
      text: plant.plantingDate != null
          ? DateFormat.yMd(locale).format(plant.plantingDate!)
          : '',
    );

    final plantSpecies = species.firstWhere(
      (element) => element.id == plant.speciesId,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.lightGreen.withAlpha(50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              SeedLibraryTextConstants.plantDetail,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextEntry(controller: name, label: SeedLibraryTextConstants.name),
            const SizedBox(height: 20),
            if (plant.nickname != null) ...[
              Text(
                '${SeedLibraryTextConstants.reference} ${plant.plantReference}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
            Text(
              '${SeedLibraryTextConstants.species} ${plantSpecies.name}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '${SeedLibraryTextConstants.type} ${plantSpecies.type.name}',
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  SeedLibraryTextConstants.difficulty,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                ...List.generate(plantSpecies.difficulty, (index) {
                  return Icon(
                    Icons.star,
                    color: function.getColorFromDifficulty(
                      plantSpecies.difficulty,
                    ),
                    size: 15,
                  );
                }),
              ],
            ),
            if (plantSpecies.card != null && plantSpecies.card != "") ...[
              const SizedBox(height: 10),
              WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    Color.fromARGB(255, 58, 188, 26),
                    Color.fromARGB(255, 19, 116, 16),
                  ],
                  child: child,
                ),
                child: const Text(
                  SeedLibraryTextConstants.speciesHelp,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  function.openLink(plantSpecies.card!);
                  return Future.value();
                },
              ),
            ],
            const SizedBox(height: 20),
            Text(
              '${SeedLibraryTextConstants.propagationMethod} ${plant.propagationMethod.name}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '${SeedLibraryTextConstants.seedQuantity} ${plant.nbSeedsEnvelope}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '${SeedLibraryTextConstants.borrowingDate} ${DateFormat.yMd(locale).format(plant.borrowingDate!)}',
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            if (plant.plantingDate == null) ...[
              WaitingButton(
                onTap: () {
                  plantNotifier.updatePlant(
                    plant.copyWith(plantingDate: DateTime.now()),
                  );
                  plantationDate.text = DateFormat.yMd(
                    locale,
                  ).format(DateTime.now());
                  myPlantsNotifier.updatePlantInList(
                    plant
                        .copyWith(plantingDate: DateTime.now())
                        .toPlantSimple(),
                  );
                  return Future.value();
                },
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    Color.fromARGB(255, 58, 188, 26),
                    Color.fromARGB(255, 19, 116, 16),
                  ],
                  child: child,
                ),
                waitingColor: Colors.green,
                child: const Text(
                  SeedLibraryTextConstants.plantingNow,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
            ],
            if (plant.plantingDate != null &&
                plant.state != function.State.consumed) ...[
              WaitingButton(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBox(
                        title: SeedLibraryTextConstants.deadPlant,
                        descriptions: SeedLibraryTextConstants.deadMsg,
                        onYes: () async {
                          final result = await plantNotifier.updatePlant(
                            plant.copyWith(
                              state: function.State.consumed,
                              plantingDate: DateTime.now(),
                            ),
                          );
                          if (result) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              SeedLibraryTextConstants.updatedPlant,
                            );
                            myPlantsNotifier.updatePlantInList(
                              plant
                                  .copyWith(
                                    state: function.State.consumed,
                                    plantingDate: DateTime.now(),
                                  )
                                  .toPlantSimple(),
                            );
                            plantationDate.text = DateFormat.yMd(
                              locale,
                            ).format(DateTime.now());
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              SeedLibraryTextConstants.updatingError,
                            );
                          }
                        },
                      );
                    },
                  );
                  return Future.value();
                },
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                waitingColor: ColorConstants.gradient1,
                child: const Text(
                  SeedLibraryTextConstants.deadPlant,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
            ],
            DateEntry(
              controller: plantationDate,
              label: plant.state == function.State.consumed
                  ? SeedLibraryTextConstants.deathDate
                  : SeedLibraryTextConstants.plantingDate,
              onTap: () {
                getOnlyDayDate(
                  context,
                  plantationDate,
                  firstDate: plant.borrowingDate,
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                plantNotifier.updatePlant(
                  plant.copyWith(
                    plantingDate: plantationDate.text.isNotEmpty
                        ? DateTime.parse(processDateBack(plantationDate.text, locale.toString()))
                        : null,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            TextEntry(
              controller: notes,
              label: SeedLibraryTextConstants.notes,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 30),
            WaitingButton(
              onTap: () async {
                bool value = await plantNotifier.updatePlant(
                  plant.copyWith(
                    nickname: name.text != plant.nickname ? name.text : null,
                    currentNote: notes.text,
                  ),
                );
                if (value) {
                  displayToastWithContext(
                    TypeMsg.msg,
                    SeedLibraryTextConstants.updatedPlant,
                  );
                  myPlantsNotifier.updatePlantInList(
                    plant
                        .copyWith(
                          nickname: name.text != plant.nickname
                              ? name.text
                              : null,
                          currentNote: notes.text,
                        )
                        .toPlantSimple(),
                  );
                } else {
                  displayToastWithContext(
                    TypeMsg.error,
                    SeedLibraryTextConstants.updatingError,
                  );
                }
              },
              builder: (child) => AddEditButtonLayout(
                colors: const [
                  Color.fromARGB(255, 58, 188, 26),
                  Color.fromARGB(255, 19, 116, 16),
                ],
                child: child,
              ),
              waitingColor: Colors.green,
              child: const Text(
                SeedLibraryTextConstants.saveChanges,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
