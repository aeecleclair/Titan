import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class MyPlantListNotifier extends ListNotifierAPI<PlantSimple> {
  Openapi get plantsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<PlantSimple>> build() {
    loadMyPlants();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<PlantSimple>>> loadMyPlants() async {
    return await loadList(plantsRepository.seedLibraryPlantsUsersMeGet);
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
      data: (plants) => AsyncValue.data(plants..add(plant)),
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

final myPlantListProvider =
    NotifierProvider<MyPlantListNotifier, AsyncValue<List<PlantSimple>>>(
      MyPlantListNotifier.new,
    );

final syncMyPlantListProvider = Provider<List<PlantSimple>>((ref) {
  final plantList = ref.watch(myPlantListProvider);
  return plantList.maybeWhen(orElse: () => [], data: (plants) => plants);
});
