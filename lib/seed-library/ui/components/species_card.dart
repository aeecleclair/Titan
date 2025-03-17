import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/species.dart';

class SpeciesCard extends HookConsumerWidget {
  const SpeciesCard({
    super.key,
    required this.species,
    required this.onClicked,
  });

  final Species species;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  Text(species.name),
                  Text(species.prefix),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
