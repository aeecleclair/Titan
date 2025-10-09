import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/plant_complete_provider.dart';
import 'package:titan/seed-library/providers/plants_list_provider.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart';
import 'package:titan/seed-library/tools/functions.dart' as function;
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PlantDetailPage extends HookConsumerWidget {
  const PlantDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.watch(plantProvider);
    final plantNotifier = ref.watch(plantProvider.notifier);
    final species = ref.watch(syncSpeciesListProvider);
    final plantsNotifier = ref.watch(plantListProvider.notifier);
    final myPlantsNotifier = ref.watch(myPlantListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: Column(
        children: [
          Text(
            SeedLibraryTextConstants.plantDetail,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          AsyncChild(
            value: plant,
            builder: (context, plantComplete) {
              final plantSpecies = species.firstWhere(
                (element) => element.id == plantComplete.speciesId,
              );
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.withAlpha(100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      '${SeedLibraryTextConstants.reference} ${plantComplete.plantReference}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${SeedLibraryTextConstants.species} ${plantSpecies.name}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      '${SeedLibraryTextConstants.type} ${plantSpecies.type.name}',
                      style: const TextStyle(fontSize: 15),
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
                    if (plantSpecies.startSeason != null &&
                        plantSpecies.endSeason != null) ...[
                      Text(
                        '${SeedLibraryTextConstants.plantationPeriod} ${monthToString(plantSpecies.startSeason!.month)} - ${monthToString(plantSpecies.endSeason!.month)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                    if (plantSpecies.timeMaturation != null) ...[
                      Text(
                        '${SeedLibraryTextConstants.timeUntilMaturation} ${plantSpecies.timeMaturation!} ${SeedLibraryTextConstants.days}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                    if (plantSpecies.card != null &&
                        plantSpecies.card != "") ...[
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
                    const SizedBox(height: 10),
                    Text(
                      '${SeedLibraryTextConstants.propagationMethod} ${plantComplete.propagationMethod.name}',
                      style: TextStyle(fontSize: 15),
                    ),
                    if (plantComplete.propagationMethod ==
                        PropagationMethod.graine) ...[
                      Text(
                        '${SeedLibraryTextConstants.seedQuantity} ${plantComplete.nbSeedsEnvelope}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                    SizedBox(height: 10),
                    if (plantComplete.previousNote != null &&
                        plantComplete.previousNote != "") ...[
                      Text(
                        SeedLibraryTextConstants.notes,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        plantComplete.previousNote ?? '',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                    ],
                    WaitingButton(
                      builder: (child) => AddEditButtonLayout(
                        colors: const [
                          Color.fromARGB(255, 58, 188, 26),
                          Color.fromARGB(255, 19, 116, 14),
                        ],
                        child: child,
                      ),
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          final value = await plantNotifier.borrowIdPlant(
                            plantComplete,
                          );
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              SeedLibraryTextConstants.borrowedPlant,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              SeedLibraryTextConstants.addingError,
                            );
                          }
                          plantsNotifier.deletePlantFromList(plantComplete.id);
                          myPlantsNotifier.addPlantToList(
                            plantComplete.toPlantSimple(),
                          );
                          QR.back();
                        });
                      },
                      child: const Text(
                        SeedLibraryTextConstants.borrowPlant,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
