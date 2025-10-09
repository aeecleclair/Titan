import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart';

class PlantCard extends HookConsumerWidget {
  const PlantCard({super.key, required this.plant, required this.onClicked});

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    AutoSizeText(
                      plantSpecies.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    AutoSizeText(
                      plant.nickname ?? plant.plantReference,
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(plantSpecies.type.name, textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(plantSpecies.difficulty, (index) {
                        return Icon(
                          Icons.star,
                          color: getColorFromDifficulty(
                            plantSpecies.difficulty,
                          ),
                          size: 15,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      "${SeedLibraryTextConstants.type} ${plant.propagationMethod.name}",
                      textAlign: TextAlign.center,
                    ),
                    plant.propagationMethod == PropagationMethod.graine
                        ? Text(
                            "(${plant.nbSeedsEnvelope.toString()} ${plant.nbSeedsEnvelope > 1 ? SeedLibraryTextConstants.seeds : SeedLibraryTextConstants.seed})",
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
