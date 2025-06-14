import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/tools/repository/repository.dart';

class SpeciesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/species/";

  Future<List<Species>> getSpeciesList() async {
    return List<Species>.from(
      (await getList()).map((x) => Species.fromJson(x)),
    );
  }

  Future<List<SpeciesType>> getSpeciesTypeList() async {
    return List<SpeciesType>.from(
      (await getOne(
        "types",
      ))["species_type"].map((x) => SpeciesType.fromString(x)),
    );
  }

  Future<Species> getSpecies(String speciesId) async {
    return Species.fromJson(await getOne(speciesId));
  }

  Future<bool> deleteSpecies(String speciesId) async {
    return await delete(speciesId);
  }

  Future<bool> updateSpecies(Species species) async {
    return await update(species.toJson(), species.id);
  }

  Future<Species> createSpecies(Species species) async {
    return Species.fromJson(await create(species.toJson()));
  }
}

final speciesRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return SpeciesRepository()..setToken(token);
});
