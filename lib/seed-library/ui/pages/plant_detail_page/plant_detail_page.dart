import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/providers/plant_complete_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/tools/functions.dart';
import 'package:myecl/seed-library/tools/functions.dart' as function;
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
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
            'Détail de la plante',
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
                      'Référence : ${plantComplete.plantReference}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Espèce: ${plantSpecies.name}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Type: ${plantSpecies.type.name}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Difficulté:',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ...List.generate(
                          plantSpecies.difficulty,
                          (index) {
                            return Icon(
                              Icons.star,
                              color: function.getColorFromDifficulty(
                                plantSpecies.difficulty,
                              ),
                              size: 15,
                            );
                          },
                        ),
                      ],
                    ),
                    if (plantSpecies.startSeason != null &&
                        plantSpecies.endSeason != null) ...[
                      Text(
                        'Période de plantation : ${monthToString(plantSpecies.startSeason!.month)} - ${monthToString(plantSpecies.endSeason!.month)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                    if (plantSpecies.timeMaturation != null) ...[
                      Text(
                        'Temps avant maturation : ${plantSpecies.timeMaturation!} jours',
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
                          "Aide sur l'espèce",
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
                      'Méthode de propagation : ${plantComplete.propagationMethod.name}',
                      style: TextStyle(fontSize: 15),
                    ),
                    if (plantComplete.propagationMethod ==
                        PropagationMethod.graine) ...[
                      Text(
                        'Nombre de graines : ${plantComplete.nbSeedsEnvelope}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                    SizedBox(height: 10),
                    if (plantComplete.previousNote != null &&
                        plantComplete.previousNote != "") ...[
                      Text(
                        'Notes :',
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
                          final value =
                              await plantNotifier.borrowIdPlant(plantComplete);
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
                          myPlantsNotifier
                              .addPlantToList(plantComplete.toPlantSimple());
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
