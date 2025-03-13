import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/providers/plant_complete_provider.dart';
import 'package:myecl/seed-library/providers/plants_filtered_list_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/ui/components/filters_bar.dart';
import 'package:myecl/seed-library/ui/components/plant_card.dart';
import 'package:myecl/seed-library/ui/components/research_bar.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StockPage extends HookConsumerWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantNotifier = ref.watch(plantProvider.notifier);
    final plantListNotifier = ref.watch(plantListProvider.notifier);
    final plantFilteredList = ref.watch(plantsFilteredListProvider);

    return SeedLibraryTemplate(
      child: Refresher(
        onRefresh: () async {
          await plantListNotifier.loadPlants();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const ResearchBar(),
              const FiltersBar(),
              const SizedBox(height: 10),
              ...plantFilteredList.map(
                (plant) => PlantCard(
                  plant: plant,
                  onClicked: () {
                    plantNotifier.loadPlant(plant.id);
                    QR.to(
                      SeedLibraryRouter.root +
                          SeedLibraryRouter.stock +
                          SeedLibraryRouter.plantDetail,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
