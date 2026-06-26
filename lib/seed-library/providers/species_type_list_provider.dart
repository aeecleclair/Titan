import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SpeciesListNotifier extends SingleNotifierAPI<SpeciesTypesReturn> {
  Openapi get speciesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<SpeciesTypesReturn> build() {
    loadSpeciesTypes();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<SpeciesTypesReturn>> loadSpeciesTypes() async {
    return await load(speciesRepository.seedLibrarySpeciesTypesGet);
  }
}

final speciesTypeListProvider =
    NotifierProvider<SpeciesListNotifier, AsyncValue<SpeciesTypesReturn>>(
      SpeciesListNotifier.new,
    );

final syncSpeciesTypeListProvider = Provider<SpeciesTypesReturn>((ref) {
  final speciesList = ref.watch(speciesTypeListProvider);
  return speciesList.maybeWhen(
    orElse: () => SpeciesTypesReturn(speciesType: []),
    data: (speciesType) => speciesType,
  );
});
