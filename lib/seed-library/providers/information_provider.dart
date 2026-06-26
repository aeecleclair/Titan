import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class InformationNotifier extends SingleNotifierAPI<SeedLibraryInformation> {
  Openapi get informationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<SeedLibraryInformation> build() {
    loadInformation();
    return const AsyncLoading();
  }

  Future<AsyncValue<SeedLibraryInformation>> loadInformation() async {
    return await load(informationRepository.seedLibraryInformationGet);
  }

  Future<bool> updateInformation(SeedLibraryInformation information) async {
    return await update(
      () =>
          informationRepository.seedLibraryInformationPatch(body: information),
      information,
    );
  }
}

final informationProvider =
    NotifierProvider<InformationNotifier, AsyncValue<SeedLibraryInformation>>(
      InformationNotifier.new,
    );

final syncInformationProvider = Provider<SeedLibraryInformation>((ref) {
  final info = ref.watch(informationProvider);
  return info.maybeWhen(
    data: (data) => data,
    orElse: () => SeedLibraryInformation.empty(),
  );
});
