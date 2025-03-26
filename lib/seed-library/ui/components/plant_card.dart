import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class PlantCard extends HookConsumerWidget {
  const PlantCard({
    super.key,
    required this.plant,
    required this.onClicked,
  });

  final PlantSimple plant;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(syncSpeciesListProvider);
    final plantSpecies = species.firstWhere(
      (element) => element.id == plant.speciesId,
    );

    return GestureDetector(
      onTap: onClicked,
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    plantSpecies.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(plant.nickname ?? plant.plantReference),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(plantSpecies.type.name),
                  Row(
                    children: List.generate(plantSpecies.difficulty, (index) {
                      return Icon(
                        Icons.star,
                        color: getColorFromDifficulty(plantSpecies.difficulty),
                        size: 15,
                      );
                    }),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text("Type : ${plant.propagationMethod.name}"),
                  plant.propagationMethod == PropagationMethod.graine
                      ? Text(
                          "(${plant.nbSeedsEnvelope.toString()} ${plant.nbSeedsEnvelope > 1 ? SeedLibraryTextConstants.seeds : SeedLibraryTextConstants.seed})",
                        )
                      : const SizedBox(),
                ],
              ),
              plant.plantingDate != null
                  ? Column(
                      children: [
                        const Text('Planté le :'),
                        Text(
                          processDate(plant.plantingDate!),
                        ),
                        const SizedBox(height: 10),
                        ...plantSpecies.timeMaturation != null
                            ? [
                                const Text('Temps avant maturation :'),
                                Text(
                                  "${(plantSpecies.timeMaturation! - DateTime.now().difference(plant.plantingDate!).inDays).toString()} jours",
                                ),
                              ]
                            : [],
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
