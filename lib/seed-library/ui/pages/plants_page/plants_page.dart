import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/providers/consumed_filter_provider.dart';
import 'package:myecl/seed-library/providers/plant_complete_provider.dart';
import 'package:myecl/seed-library/providers/plants_filtered_list_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/ui/components/filters_bar.dart';
import 'package:myecl/seed-library/ui/pages/plants_page/personal_plant_card.dart';
import 'package:myecl/seed-library/ui/components/research_bar.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PlantsPage extends HookConsumerWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantNotifier = ref.watch(plantProvider.notifier);
    final plantListNotifier = ref.watch(plantListProvider.notifier);
    final plantFilteredList = ref.watch(myPlantsFilteredListProvider);
    final consumedFilter = ref.watch(consumedFilterProvider);
    final consumedFilterNotifier = ref.watch(consumedFilterProvider.notifier);

    return SeedLibraryTemplate(
      child: Refresher(
        onRefresh: () async {
          await plantListNotifier.loadPlants();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                SeedLibraryTextConstants.myPlants,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const ResearchBar(),
              const SizedBox(height: 10),
              const FiltersBar(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: consumedFilter,
                    onChanged: (value) =>
                        consumedFilterNotifier.setBool(value ?? false),
                  ),
                  Text(SeedLibraryTextConstants.showDeadPlants),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ...plantFilteredList.map(
                      (plant) => PersonalPlantCard(
                        plant: plant,
                        onClicked: () async {
                          plantNotifier.loadPlant(plant.id);
                          QR.to(
                            SeedLibraryRouter.root +
                                SeedLibraryRouter.plants +
                                SeedLibraryRouter.plantDetail,
                          );
                        },
                      ),
                    ),
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
