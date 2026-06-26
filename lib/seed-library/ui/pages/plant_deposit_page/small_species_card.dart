import 'package:flutter/material.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SmallSpeciesCard extends StatelessWidget {
  const SmallSpeciesCard({
    super.key,
    required this.species,
    required this.onClicked,
    required this.selected,
  });

  final SpeciesComplete species;
  final VoidCallback onClicked;
  final bool selected;

  @override
  Widget build(BuildContext context) {
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
                species.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(species.prefix),
            ],
          ),
        ),
      ),
    );
  }
}
