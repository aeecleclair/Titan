import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart' as function;

class PersonalPlantCard extends HookConsumerWidget {
  const PersonalPlantCard({
    super.key,
    required this.plant,
    required this.onClicked,
  });

  final PlantSimple plant;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      plant.nickname ?? plant.plantReference,
                      minFontSize: 10,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              plant.plantingDate != null
                  ? SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            plant.state == function.State.consumed
                                ? SeedLibraryTextConstants.deathDate
                                : SeedLibraryTextConstants.plantingDate,
                          ),
                          Text(
                            DateFormat.yMd(locale).format(plant.plantingDate!),
                          ),
                          ...plantSpecies.timeMaturation != null &&
                                  plant.state != function.State.consumed
                              ? [
                                  Text(
                                    SeedLibraryTextConstants
                                        .timeUntilMaturation,
                                  ),
                                  Text(
                                    "${(plantSpecies.timeMaturation! - DateTime.now().difference(plant.plantingDate!).inDays).toString()} ${SeedLibraryTextConstants.days}",
                                    style: TextStyle(
                                      color:
                                          plantSpecies.timeMaturation! -
                                                  DateTime.now()
                                                      .difference(
                                                        plant.plantingDate!,
                                                      )
                                                      .inDays <=
                                              0
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ]
                              : [],
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
