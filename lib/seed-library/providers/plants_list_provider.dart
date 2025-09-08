import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/plant_creation.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/repositories/plants_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PlantListNotifier extends ListNotifier<PlantSimple> {
  final PlantsRepository plantsRepository;
  PlantListNotifier({required this.plantsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<PlantSimple>>> loadPlants() async {
    return await loadList(plantsRepository.getPlantSimplelist);
  }

  Future<AsyncValue<List<PlantSimple>>> loadMyPlants() async {
    return await loadList(plantsRepository.getMyPlantSimple);
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

  void deletePlantFromList(String id) {
    state = state.maybeWhen(
      orElse: () => state,
      data: (plants) => AsyncValue.data(plants..removeWhere((i) => i.id == id)),
    );
  }

  void addPlantToList(PlantSimple plant) {
    state = state.maybeWhen(
      orElse: () => state,
      data: (plants) => AsyncValue.data([...plants, plant]),
    );
  }

  void updatePlantInList(PlantSimple plant) {
    state = state.maybeWhen(
      orElse: () => state,
      data: (plants) => AsyncValue.data(
        plants.map((i) => i.id == plant.id ? plant : i).toList(),
      ),
    );
  }
}

final plantListProvider =
    StateNotifierProvider<PlantListNotifier, AsyncValue<List<PlantSimple>>>((
      ref,
    ) {
      final plantRepository = ref.watch(plantsRepositoryProvider);
      PlantListNotifier provider = PlantListNotifier(
        plantsRepository: plantRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadPlants();
      });
      return provider;
    });

final syncPlantListProvider = Provider<List<PlantSimple>>((ref) {
  final plantList = ref.watch(plantListProvider);
  return plantList.maybeWhen(orElse: () => [], data: (plants) => plants);
});

final myPlantListProvider =
    StateNotifierProvider<PlantListNotifier, AsyncValue<List<PlantSimple>>>((
      ref,
    ) {
      final plantRepository = ref.watch(plantsRepositoryProvider);
      PlantListNotifier provider = PlantListNotifier(
        plantsRepository: plantRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadMyPlants();
      });
      return provider;
    });

final syncMyPlantListProvider = Provider<List<PlantSimple>>((ref) {
  final plantList = ref.watch(myPlantListProvider);
  return plantList.maybeWhen(orElse: () => [], data: (plants) => plants);
});
