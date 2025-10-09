import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/seed-library/repositories/species_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SpeciesListNotifier extends ListNotifier<SpeciesType> {
  final SpeciesRepository speciesRepository;
  SpeciesListNotifier({required this.speciesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<SpeciesType>>> loadSpeciesTypes() async {
    return await loadList(speciesRepository.getSpeciesTypeList);
  }
}

final speciesTypeListProvider =
    StateNotifierProvider<SpeciesListNotifier, AsyncValue<List<SpeciesType>>>((
      ref,
    ) {
      final speciesRepository = ref.watch(speciesRepositoryProvider);
      SpeciesListNotifier provider = SpeciesListNotifier(
        speciesRepository: speciesRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadSpeciesTypes();
      });
      return provider;
    });

final syncSpeciesTypeListProvider = Provider<List<SpeciesType>>((ref) {
  final speciesList = ref.watch(speciesTypeListProvider);
  return speciesList.maybeWhen(
    orElse: () => [],
    data: (speciesType) => speciesType,
  );
});
