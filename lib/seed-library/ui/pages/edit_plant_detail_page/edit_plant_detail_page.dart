import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/plant_complete_provider.dart';
import 'package:titan/seed-library/ui/pages/edit_plant_detail_page/editable_plant_detail.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class EditPlantDetailPage extends HookConsumerWidget {
  const EditPlantDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.watch(plantProvider);

    return SeedLibraryTemplate(
      child: AsyncChild(
        value: plant,
        builder: (context, value) => EditablePlantDetail(plant: value),
      ),
    );
  }
}
