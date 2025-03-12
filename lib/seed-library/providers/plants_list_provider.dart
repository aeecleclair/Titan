import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/plant_creation.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/repositories/plants_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PlantListNotifier extends ListNotifier<PlantSimple> {
  final PlantsRepository plantsRepository;
  PlantListNotifier({required this.plantsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PlantSimple>>> loadPlants() async {
    return await loadList(plantsRepository.getPlantSimplelist);
  }

  Future<bool> createPlant(PlantCreation plant) async {
    return await add(
      (plantSimple) => plantsRepository.createPlants(plant),
      PlantSimple.empty(),
    );
  }

  Future<bool> deletePlant(PlantSimple plant) async {
    return await delete(
      plantsRepository.deletePlants,
      (plants, plant) => plants..removeWhere((i) => i.id == plant.id),
      plant.id,
      plant,
    );
  }
}

final plantListProvider =
    StateNotifierProvider<PlantListNotifier, AsyncValue<List<PlantSimple>>>(
        (ref) {
  final plantRepository = ref.watch(plantsRepositoryProvider);
  PlantListNotifier provider =
      PlantListNotifier(plantsRepository: plantRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadPlants();
  });
  return provider;
});
