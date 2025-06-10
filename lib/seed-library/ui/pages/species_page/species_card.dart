import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/tools/functions.dart' as function;
import 'package:titan/seed-library/ui/components/delete_button.dart';
import 'package:titan/seed-library/ui/components/edition_button.dart';

class SpeciesCard extends HookConsumerWidget {
  const SpeciesCard({
    super.key,
    required this.species,
    required this.onEdit,
    required this.onDelete,
  });

  final Species species;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(width: 10),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(species.name, textAlign: TextAlign.center),
                  Text(species.prefix, textAlign: TextAlign.center),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(species.type.name, textAlign: TextAlign.center),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(species.difficulty, (index) {
                        return Icon(
                          Icons.star,
                          color: function.getColorFromDifficulty(
                            species.difficulty,
                          ),
                          size: 15,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            EditionButton(onEdition: onEdit, deactivated: false),
            const SizedBox(width: 5),
            DeleteButton(
              onDelete: onDelete,
              deactivated: false,
              deletion: true,
            ),
          ],
        ),
      ),
    );
  }
}
