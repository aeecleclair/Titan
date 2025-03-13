import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/seed-library/class/species.dart';
import 'package:myecl/seed-library/tools/fake_data.dart';
import 'package:myecl/tools/repository/repository.dart';

class SpeciesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/species/";

  Future<List<Species>> getSpeciesList() async {
    return speciesList;
    // return List<Species>.from(
    //   (await getList()).map((x) => Species.fromJson(x)),
    // );
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
