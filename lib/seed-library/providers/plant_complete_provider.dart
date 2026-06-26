import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PlantNotifier extends SingleNotifierAPI<PlantComplete> {
  Openapi get plantsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<PlantComplete> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<PlantComplete>> loadPlant(String plantId) async {
    return await load(
      () => plantsRepository.seedLibraryPlantsPlantIdGet(plantId: plantId),
    );
  }

  Future<bool> updatePlant(PlantComplete plant) async {
    return await update(
      () => plantsRepository.seedLibraryPlantsPlantIdPatch(
        plantId: plant.id,
        body: PlantEdit(
          state: plant.state,
          currentNote: plant.currentNote,
          confidential: plant.confidential,
          plantingDate: plant.plantingDate,
          borrowingDate: plant.borrowingDate,
          nickname: plant.nickname,
        ),
      ),
      plant,
    );
  }

  Future<bool> borrowIdPlant(PlantComplete plant) async {
    return await update(
      () => plantsRepository.seedLibraryPlantsPlantIdBorrowPatch(
        plantId: plant.id,
      ),
      plant,
    );
  }

  void setPlant(PlantComplete plant) {
    state = AsyncValue.data(plant);
  }
}

final plantProvider =
    NotifierProvider<PlantNotifier, AsyncValue<PlantComplete>>(
      PlantNotifier.new,
    );
