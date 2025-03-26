import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/species.dart';
import 'package:myecl/seed-library/ui/components/delete_button.dart';
import 'package:myecl/seed-library/ui/components/edition_button.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(width: 10),
            Column(
              children: [
                Text(species.name),
                Text(species.prefix),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(species.type.name),
                Text("Difficulté : ${species.difficulty.toString()}"),
              ],
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
