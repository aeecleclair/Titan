import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SpeciesListNotifier extends ListNotifierAPI<SpeciesComplete> {
  Openapi get speciesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<SpeciesComplete>> build() {
    loadSpecies();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<SpeciesComplete>>> loadSpecies() async {
    return await loadList(speciesRepository.seedLibrarySpeciesGet);
  }

  Future<bool> createSpecies(SpeciesComplete species) async {
    return await add(
      () => speciesRepository.seedLibrarySpeciesPost(
        body: SpeciesBase(
          prefix: species.prefix,
          name: species.name,
          difficulty: species.difficulty,
          speciesType: species.speciesType,
          card: species.card,
          nbSeedsRecommended: species.nbSeedsRecommended,
          startSeason: species.startSeason,
          endSeason: species.endSeason,
          timeMaturation: species.timeMaturation,
        ),
      ),
      species,
    );
  }

  Future<bool> updateSpecies(SpeciesComplete species) async {
    return await update(
      () => speciesRepository.seedLibrarySpeciesSpeciesIdPatch(
        speciesId: species.id,
        body: SpeciesEdit(
          prefix: species.prefix,
          name: species.name,
          difficulty: species.difficulty,
          speciesType: species.speciesType,
          card: species.card,
          nbSeedsRecommended: species.nbSeedsRecommended,
          startSeason: species.startSeason,
          endSeason: species.endSeason,
          timeMaturation: species.timeMaturation,
        ),
      ),
      (species) => species.id,
      species,
    );
  }

  Future<bool> deleteSpecie(SpeciesComplete species) async {
    return await delete(
      () => speciesRepository.seedLibrarySpeciesSpeciesIdDelete(
        speciesId: species.id,
      ),
      (species) => species.id,
      species.id,
    );
  }
}

final speciesListProvider =
    NotifierProvider<SpeciesListNotifier, AsyncValue<List<SpeciesComplete>>>(
      SpeciesListNotifier.new,
    );

final syncSpeciesListProvider = Provider<List<SpeciesComplete>>((ref) {
  final speciesList = ref.watch(speciesListProvider);
  return speciesList.maybeWhen(orElse: () => [], data: (species) => species);
});
