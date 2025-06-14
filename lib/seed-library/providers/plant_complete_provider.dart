import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/plant_complete.dart';
import 'package:titan/seed-library/repositories/plants_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class PlantNotifier extends SingleNotifier<PlantComplete> {
  final PlantsRepository plantsRepository;
  PlantNotifier({required this.plantsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<PlantComplete>> loadPlant(String plantId) async {
    return await load(() => plantsRepository.getPlantComplete(plantId));
  }

  Future<bool> updatePlant(PlantComplete plant) async {
    return await update(plantsRepository.updatePlant, plant);
  }

  Future<bool> borrowIdPlant(PlantComplete plant) async {
    return await update(plantsRepository.borrowIdPlant, plant);
  }

  void setPlant(PlantComplete plant) {
    state = AsyncValue.data(plant);
  }
}

final plantProvider =
    StateNotifierProvider<PlantNotifier, AsyncValue<PlantComplete>>((ref) {
      final plantRepository = ref.watch(plantsRepositoryProvider);
      return PlantNotifier(plantsRepository: plantRepository);
    });
