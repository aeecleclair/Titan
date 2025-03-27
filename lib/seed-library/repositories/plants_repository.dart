import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/seed-library/class/plant_complete.dart';
import 'package:myecl/seed-library/class/plant_creation.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/tools/repository/repository.dart';

class PlantsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/plants/";

  Future<List<PlantSimple>> getPlantSimplelist() async {
    final result = await getList(suffix: "waiting");
    print(result);
    return List<PlantSimple>.from(
      result.map((x) => PlantSimple.fromJson(x)),
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
      (await getList(suffix: "users/$userId"))
          .map((x) => PlantSimple.fromJson(x)),
    );
  }

  Future<List<PlantSimple>> getMyPlantSimple() async {
    final result = await getList(suffix: "users/me");
    print(result);
    return List<PlantSimple>.from(
      (result).map((x) => PlantSimple.fromJson(x)),
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
