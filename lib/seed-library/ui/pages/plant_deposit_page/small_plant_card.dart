import 'package:flutter/material.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/class/species.dart';

class SmallPlantCard extends StatelessWidget {
  const SmallPlantCard({
    super.key,
    required this.plant,
    required this.species,
    required this.onClicked,
    required this.selected,
  });

  final PlantSimple plant;
  final List<Species> species;
  final VoidCallback onClicked;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final plantSpecies = species.firstWhere(
      (element) => element.id == plant.speciesId,
    );

    return GestureDetector(
      onTap: onClicked,
      child: Card(
        color: selected ? Colors.green[300] : null,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
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
        ),
      ),
    );
  }
}
