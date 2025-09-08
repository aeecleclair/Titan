import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/seed-library/class/plant_complete.dart';
import 'package:titan/seed-library/class/plant_creation.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/tools/repository/repository.dart';

class PlantsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/plants/";

  Future<List<PlantSimple>> getPlantSimplelist() async {
    return List<PlantSimple>.from(
      (await getList(suffix: "waiting")).map((x) => PlantSimple.fromJson(x)),
    );
  }

  Future<PlantComplete> getPlantComplete(String plantId) async {
    return PlantComplete.fromJson(await getOne(plantId));
  }

  Future<PlantSimple> getwaitingPlants(String plantsId) async {
    return PlantSimple.fromJson(await getOne(plantsId));
  }

  Future<List<PlantSimple>> getListPlantSimpleAdmin(String userId) async {
    return List<PlantSimple>.from(
      (await getList(
        suffix: "users/$userId",
      )).map((x) => PlantSimple.fromJson(x)),
    );
  }

  Future<List<PlantSimple>> getMyPlantSimple() async {
    return List<PlantSimple>.from(
      (await getList(suffix: "users/me")).map((x) => PlantSimple.fromJson(x)),
    );
  }

  Future<bool> deletePlants(String plantsId) async {
    return await delete(plantsId);
  }

  Future<bool> updatePlant(PlantComplete plant) async {
    return await update(plant.toJson(), plant.id);
  }

  Future<bool> borrowIdPlant(PlantComplete plant) async {
    return await update({}, plant.id, suffix: "/borrow");
  }

  Future<PlantSimple> createPlants(PlantCreation plants) async {
    return PlantSimple.fromJson(await create(plants.toJson()));
  }
}

final plantsRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return PlantsRepository()..setToken(token);
});
