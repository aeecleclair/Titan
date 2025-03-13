import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';

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
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(plant.nickname ?? plant.plantReference),
                  Row(
                    children: [
                      Text(plantSpecies.name),
                      SizedBox(width: 10),
                      Text(plantSpecies.type.name),
                    ],
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
