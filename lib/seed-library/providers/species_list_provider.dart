import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/repositories/species_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SpeciesListNotifier extends ListNotifier<Species> {
  final SpeciesRepository speciesRepository;
  SpeciesListNotifier({required this.speciesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Species>>> loadSpecies() async {
    return await loadList(speciesRepository.getSpeciesList);
  }

  Future<bool> createSpecies(Species species) async {
    return await add(speciesRepository.createSpecies, species);
  }

  Future<bool> updateSpecies(Species species) async {
    return await update(
      speciesRepository.updateSpecies,
      (species, specie) => species
        ..removeWhere((i) => i.id == specie.id)
        ..add(specie),
      species,
    );
  }

  Future<bool> deleteSpecie(Species specie) async {
    return await delete(
      speciesRepository.deleteSpecies,
      (species, specie) => species..removeWhere((i) => i.id == specie.id),
      specie.id,
      specie,
    );
  }
}

final speciesListProvider =
    StateNotifierProvider<SpeciesListNotifier, AsyncValue<List<Species>>>((
      ref,
    ) {
      final speciesRepository = ref.watch(speciesRepositoryProvider);
      SpeciesListNotifier provider = SpeciesListNotifier(
        speciesRepository: speciesRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadSpecies();
      });
      return provider;
    });

final syncSpeciesListProvider = Provider<List<Species>>((ref) {
  final speciesList = ref.watch(speciesListProvider);
  return speciesList.maybeWhen(orElse: () => [], data: (species) => species);
});
