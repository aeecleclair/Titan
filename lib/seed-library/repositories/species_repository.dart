import 'package:myecl/seed-library/class/species.dart';
import 'package:myecl/seed-library/class/species_type.dart';
import 'package:myecl/tools/repository/repository.dart';

class SpeciesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/species/";

  SpeciesRepository(super.ref);

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
